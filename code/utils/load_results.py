import os
import pandas as pd
import numpy as np


def load_robustness_loadings(path, method, n_components, iterations):
    """
    Loads loading matrices from csv files as a list of 
    3D numpy arrays (iterations x variables x components).
    This means there is one array per number of components.
    """
    # load results
    loadings = []
    folder = f"{method}_{n_components}-components_{iterations}-iterations"
    subfolders = sorted(os.listdir(os.path.join(path, folder)))

    for sf in subfolders:
        matrices = []
        sfpath = os.path.join(path, folder, sf)
        csvs = sorted(os.listdir(sfpath))
        for csv in csvs:
            csvpath = os.path.join(sfpath, csv)
            matrix = pd.read_csv(csvpath, index_col=0).to_numpy()
            matrices.append(matrix)
        loadings.append(np.array(matrices))
    ## reorder
    #ac_reordered = sorted(abs_correlations, key=lambda i: len(i))
    ## expand dimensions of 1 factor data
    #ac_reordered[-1] = np.expand_dims(ac_reordered[-1], axis=0)
    ## reorder again
    #ac_reordered = sorted(ac_reordered, key=lambda i: len(i))
    return loadings

def load_consensus_matrices(path):
    Mks = []
    files = os.listdir(path)
    files.sort()
    for f in files:
        if not f.startswith("."):
            Mks.append(pd.read_csv(os.path.join(path, f),
                                   index_col=0))
    return Mks