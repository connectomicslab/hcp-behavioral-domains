import math
import pandas as pd
import numpy as np
import seaborn as sns
import networkx as nx
import matplotlib.pyplot as plt
from scipy.cluster import hierarchy

def visualize_loadings(loadings, ordered = False, save = False):
    sns.set(rc={'figure.figsize':(25,25)})
    for i, l in enumerate(loadings):
        if ordered == True:
            l_ordered = l.sort_values(by=l.columns[0])
            sns.heatmap(l_ordered, cmap='coolwarm_r', center=0)
            if save == True:
                plt.savefig(f"loadings_{i+1}-factors.png")
            plt.show()
        else:
            sns.heatmap(l, cmap='coolwarm_r', center=0)
            if save == True:
                plt.savefig(f"loadings_{i+1}-factors.png")
            plt.show()
            

def calculate_path_coef(scores):
    path_coef = []
    for i in range(len(scores)):
        if i != (len(scores)-1):
            correlations = scores[i].apply(lambda s: scores[i+1].corrwith(s))
            path_coef.append(correlations)

    level = 0
    for p in path_coef:
        level+=1
        if level < 9:
            p.columns = p.columns+"_0"+str(level)
            p.index = p.index+"_0"+str(level+1)
        elif level == 9:
            p.columns = p.columns+"_0"+str(level)
            p.index = p.index+"_"+str(level+1)
        else:
            p.columns = p.columns+"_"+str(level)
            p.index = p.index+"_"+str(level+1)
    return path_coef
            
            
def create_hierarchy_network(path_coef, threshold = 0):
    # Create network
    Gt = nx.DiGraph()

    # Add nodes
    layer = 0 # layer counter
    for p in path_coef:
        layer += 1
        no = 0 # number inside layer counter
        for c in p.columns:
            no +=1
            Gt.add_node(c, pos=(no, -layer), order=layer)
        if layer == len(path_coef): # add nodes from last layer
            no = 0
            for i in p.index:
                no += 1
                Gt.add_node(i, pos=(no, -layer-1), order=layer+1)

    # Add edges with weights
    for p in path_coef:
        for c in p.columns:
            for i in p.index:
                if p.at[i,c] > threshold or p.at[i,c] < -threshold:
                    Gt.add_edge(c,i, weight=p.at[i,c])
    return Gt


def visualize_network(G, save=False):
    # Draw graph
    import matplotlib.pyplot as plt
    pos = nx.get_node_attributes(G, "pos")
    weights = nx.get_edge_attributes(G, "weight").values()
    size = list(nx.get_node_attributes(G, "pos").values())[-1][0]
    sns.set(rc={'figure.figsize':(size*1.2,size)})
    #print(weights)
    nx.draw(G, pos=pos, with_labels=True, font_weight="bold", width=list(weights))
    if save == True:
        plt.savefig("hierarchy.svg")
        
def dist_summary(var):
    print("Minimum:", min(var))
    print("Maximum:", max(var))
    print("Median:", np.median(var))
    print("Mean:", np.mean(var))
    # sns.displot(data=var)


def dist_plots(data, hue=None):
    fig, axs = plt.subplots(math.ceil(len(data.columns)/5), 5, figsize=(20,30), tight_layout=True)
    axs = axs.flatten()
    for i, col in enumerate(data.columns):
        sns.stripplot(data=data, x='group', y=col, ax=axs[i])
        
def ordered_corr_matrix(data):
    X = np.array(data).transpose() #transpose matrix

    # create correlation matrix
    corr_matrix = data.corr()

    # make array of absolute correlation
    corr_array = np.array(corr_matrix)
    abs_corr_array = abs(corr_array)

    # fit clustering algorithm
    Z = hierarchy.linkage(X, metric="euclidean", method = 'ward')
    idx = (hierarchy.leaves_list(hierarchy.optimal_leaf_ordering(Z,X))) #indices with optimal leaf order

    # reorder correlation matrix
    row_ordered = corr_array[:,list(idx)] #reorder rows
    col_ordered = row_ordered[list(idx),:] #reorder columns
    np.fill_diagonal(col_ordered,0) #set main diagonal to 0 for better visibility

    # reordered labels list
    labels = corr_matrix.columns[idx]

    # convert back to dataframe
    corr_ordered = pd.DataFrame(data=col_ordered,index=labels, columns=labels)
    
    return corr_ordered

def plot_corr_interactive(corr_matrix):
    fig = px.imshow(corr_ordered, color_continuous_scale=px.colors.diverging.RdBu,#[::-1],
                color_continuous_midpoint=0,
                width=980, height=908)
    fig.show()
    return

def plot_corr_static(corr_matrix, size='big', save_fig=False):
    if size == 'big':
        figsize = (25, 20)
    else:
        figsize = (6, 5)
    fig, ax = plt.subplots(1, 1, figsize=figsize)
    sns.heatmap(corr_matrix, cmap='icefire_r', center=0)
    if size == 'small':
        ax.axis('off')
    if save_fig:
        fig.savefig(f"../outputs/plots/efa/correlation_matrix_{size}.svg")
    return

def plot_pa_single(ev, avg_eig, save_plot = False):
    # plot eigenvalues of actual and random data
    sns.set_theme(style='white')
    fig, ax = plt.subplots(1, 1, figsize=(6,5))
    ax.plot(range(len(ev)), ev, marker="1", label="Real Data")
    ax.plot(range(len(ev)), avg_eig, marker="2", label="Synthetic Data")
    ax.set_xticks(range(0, len(ev), 10))
    ax.set_yticks(range(0, 13, 1))
    ax.set_xlabel('Factor Number')
    ax.set_ylabel('Eigenvalue')
    ax.set_title('Parallel Analysis')
    ax.legend()
    sns.despine()
    if save_plot == True:
        fig.savefig(outpath_efa+"parallel_analysis.svg")
    plt.show()
    return
