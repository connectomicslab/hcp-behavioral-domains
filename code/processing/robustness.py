"""
Functions and script to run a robustness analysis
"""

import pandas as pd
import numpy as np
import os
from factor_analyzer import FactorAnalyzer
from sklearn.decomposition import PCA, FastICA
from scipy.optimize import linear_sum_assignment


def subsample(data, sample_type="subjects"):
    """
    Draws a sample of the dataset.
    :param data: Dataframe to sample from
    :param sample_type: "subjects" or "variables"
    :return:
    """
    if sample_type == "subjects":
        sample = data.sample(frac=0.8, replace=False)
    elif sample_type == "variables":
        sample = data.sample(frac=0.8, replace=False, axis=1)
    return sample


def run_method(data, n_factors, iterations, sample_type, method):
    # run method for specified number of iterations
    loadings = []
    for i in range(iterations):
        print("Iteration", i + 1)
        # draw sample
        sample = subsample(data, sample_type=sample_type)

        if method == "fa":
            sample = subsample(data, sample_type=sample_type)
            if n_factors == 1:
                rotation = None
            else:
                rotation = 'varimax'
            fa = FactorAnalyzer(n_factors=n_factors, rotation=rotation, method="ml")
            fa.fit(sample)
            # save loadings
            l = fa.loadings_

        elif method == "pca":
            pca = PCA(n_components=n_factors)
            pca.fit(sample)
            # varimax rotation
            pca_c_rot = ortho_rotation(pca.components_.T)
            # calculate loadings
            l = pca_c_rot * np.sqrt(pca.explained_variance_)

        elif method == "ica":
            ica = FastICA(n_components=n_factors, max_iter=1000)
            s = ica.fit_transform(sample)
            # construct loading matrix: correlation between components and variables
            l = np.empty((sample.shape[1], n_factors))
            for i, ic in enumerate(s.T):
                for j, v in enumerate(sample.to_numpy().T):
                    l[j, i] = np.corrcoef(ic, v)[0, 1]
        else:
            raise NotImplementedError

        loadings.append(l)
    return loadings


# orthogonal rotation method from scikit-learn's factor analysis
def ortho_rotation(components, method="varimax", tol=1e-6, max_iter=100):
    """Return rotated components."""
    nrow, ncol = components.shape
    rotation_matrix = np.eye(ncol)
    var = 0

    for _ in range(max_iter):
        comp_rot = np.dot(components, rotation_matrix)
        if method == "varimax":
            tmp = comp_rot * np.transpose((comp_rot ** 2).sum(axis=0) / nrow)
        elif method == "quartimax":
            tmp = 0
        u, s, v = np.linalg.svd(np.dot(components.T, comp_rot ** 3 - tmp))
        rotation_matrix = np.dot(u, v)
        var_new = np.sum(s)
        if var != 0 and var_new < var * (1 + tol):
            break
        var = var_new

    return np.dot(components, rotation_matrix)


def reorder_factors(loadings):
    n_factors = loadings[0].shape[1]
    loadings_reordered = []
    for i, l in enumerate(loadings):
        # skip first set of loadings
        if i == 0:
            loadings_reordered.append(l)
            continue
        corr_matrix = 1-abs(np.corrcoef(loadings[0], l, rowvar=False))
        cost_matrix = corr_matrix[-n_factors:,:n_factors].T
        # calculate optimal ordering
        row_ind, col_ind = linear_sum_assignment(cost_matrix)
        # reorder
        loadings_reordered.append(l[:,col_ind])
    return loadings_reordered


def calculate_abs_corr(loadings_reordered):
    loadings_np = np.array(loadings_reordered)
    abs_corr = []
    for i in range(loadings_np.shape[2]):
        # correlation matrix of loadings on the same factor between samples
        c_mat = np.corrcoef(loadings_np[:,:,i])
        # get indices of unique correlation values, upper triangle without main diagonal
        upper_tri = np.triu_indices_from(c_mat, k=1)
        # append flattened array of absolute correlations
        abs_corr.append(abs(c_mat[upper_tri]))
    return np.array(abs_corr)


def robustness(data, n_factors, method, path, iterations=1000, sample_type="subjects"):
    print(f"Running {method} with {iterations} iterations")
    # abs_correlations = []
    for i in range(1, n_factors+1):
        # create output folder
        num1 = str(i).zfill(2)
        foldername = os.path.join("loadings", f"{method}_{n_factors}-components_{iterations}-iterations", f"{num1}-components")
        folderpath = os.path.join(path, foldername)
        os.makedirs(folderpath)
        print(f"Number of factors/components: {i}")
        # get loadings of run_method samples
        loadings = run_method(data, i, iterations, sample_type, method)
        # reordered loadings
        loadings_reordered = reorder_factors(loadings)
        # save loadings
        for j, l in enumerate(loadings_reordered):
            l_df = pd.DataFrame(l)
            num2 = str(j).zfill(4)
            csvpath = os.path.join(folderpath, num2+".csv")
            l_df.to_csv(csvpath)
    return loadings_reordered


def avg_ac(abs_cor):
    """
    Create 2D array containing the average absolute correlation for each level
    and factor/component in that level in the lower triangle, with the upper
    triangle and main diagonal padded with zeros for plotting.
    """
    avg_ac = np.ones((len(abs_cor),len(abs_cor))) # array to fill
    for i, c in enumerate(abs_cor):
        #print(i+1, "factors:", np.mean(c, axis=1))
        f = np.mean(c, axis=1) # average abs. corr. over samples per factor
        n_pad = len(abs_cor[-1])-len(f) # how many zeros to pad with
        #print(type(len(abs_cor_fa[-1])-len(f)))
        v_pd = np.pad(f, (0,n_pad), mode='constant') # padded vector
        avg_ac[i] = avg_ac[i]*v_pd # update array
    return avg_ac


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument('path_data', type=str)
    parser.add_argument('max_level', type=int, help="Maximum number of levels to run")
    parser.add_argument('method', type=str, choices=['fa', 'pca', 'ica'])
    parser.add_argument('out_path', type=str)
    parser.add_argument('--iterations', type=int, default=1000)

    args = parser.parse_args()

    data = pd.read_csv(args.path_data, index_col='Subject')

    robustness(data, args.max_level, args.method, args.out_path, args.iterations)