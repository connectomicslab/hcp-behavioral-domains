"""Code to run the exploratory factor analysis on the training set"""

import pandas as pd
import numpy as np
from factor_analyzer import FactorAnalyzer


def parallel_analysis(data, k=20, method="ml", return_ev=False):
    """Parallel analysis to get the upper limit of how many factors to extract in the factor analysis.

    Parameters
    ----------
    data : DataFrame
        Behavioral data with subjects as rows and variables as columns
    k : int, optional
        How many random datasets to generate, by default 20
    method : str, optional
        Which factor extraction method to use, see factor_analyzer docs for details, by default "ml"
    return_ev : bool, optional
        Whether to return the eigenvalues from the factor analysis and the average eigenvalues from the parallel analysis, by default False

    Returns
    -------
    int(, int, int) 
        The number of factor suggested by parallel analysis and optionally the eigenvalues and average eigenvalues
    """    
    import numpy as np
    import matplotlib.pyplot as plt
    from factor_analyzer import FactorAnalyzer

    # get shape of the data
    n, m = data.shape

    # initialize FactorAnalyzer
    fa = FactorAnalyzer(n_factors=m, rotation="varimax", method=method)

    # list to store eigenvalues
    eig = np.ones((k, m))

    # loop for k iterations
    for i in range(k):
        # print("Iteration", i+1)
        # generate random data
        rnd_data = np.random.normal(size=(n, m))
        # run factor analysis
        fa.fit(rnd_data)
        # extract eigenvalues
        ev, v = fa.get_eigenvalues()
        eig[i] = eig[i] * ev

    # average eigenvalues for random data
    avg_eig = np.mean(eig, axis=0)

    # run factor analysis on data
    fa.fit(data)
    ev, v = fa.get_eigenvalues()

    # determine suggested no. of factors
    suggestedFactors = sum((ev - avg_eig) > 0)
    if return_ev:
        return suggestedFactors, ev, avg_eig
    else:
        return suggestedFactors

def calculate_scores(data, loadings, uniquenesses, method = "bartlett"):
    """Calculate factor scores.

    Parameters
    ----------
    data : DataFrame
        _description_
    loadings : ndarray
        Loading matrix.
    uniquenesses : ndarray
        Uniqueness matrix
    method : str, optional
        Method to extract scores, options are "regression" and "bartlett", by default "bartlett"

    Returns
    -------
    ndarray
        Factor score matrix.
    """
    if method == "regression":
        X = data.to_numpy()
        R = data.corr()
        R_inv = np.linalg.inv(R)
        P = loadings
        B = R_inv@P
        F = X@B
    if method == "bartlett":
        X = data.to_numpy()
        P = loadings
        U = np.diag(uniquenesses)
        U_inv = np.linalg.inv(U)
        one=P.T@U_inv
        two=P.T@U_inv@P
        B_t = np.linalg.inv(two)@one
        B = B_t.T
        F = X@B
    return F


def hierarchical_fa(data, levels, method = "ml", score_method="bartlett"):
    """Hierarchical factor analysis

    Parameters
    ----------
    data : DataFrame
        Dataset to perform the hierarchical factor analysis on
    levels : int
        How many levels to extract, corresponds to the maximum number of factors to compute
    method : str, optional
        Factor extraction method, for options see factor_analyzer documentation, by default "ml"
    score_method : str, optional
        Method to compute the factor scores, by default "bartlett"

    Returns
    -------
    DataFrame, DataFrame
        Factor loadings, factor scores
    """    
    loadings = []
    scores = []
    for lvl in range(1, levels+1):
        print("Level", lvl)
        if lvl == 1:
            fa = FactorAnalyzer(n_factors=lvl, rotation=None, method=method)
        else:
            fa = FactorAnalyzer(n_factors=lvl, rotation="varimax", method=method)
        fa.fit(data)#, lvl)
        factornames = []
        for i in range(lvl):
            factor = i+1
            factornames.append("factor"+str(factor))
        l = pd.DataFrame(fa.loadings_, index=data.columns, columns=factornames)
        if score_method == "simple":
            s = pd.DataFrame(fa.transform(data), index=data.index, columns=factornames)
        else:
            U = fa.get_uniquenesses()
            s = calculate_scores(data, fa.loadings_, U, method=score_method)
            s_pd = pd.DataFrame(s, index=data.index, columns=factornames)
        loadings.append(l)
        scores.append(s_pd)
    return loadings, scores


def calculate_variance_explained(loadings):
    """Calculates percentage of variance explained: factor loadings are squared and then summed, divided by
    number of items, times 100 for percent

    Parameters
    ----------
    loadings : list of DataFrames
        Factor loadings of several levels

    Returns
    -------
    list
        variance explained per level
    """
    var_exp = []
    for i, l in enumerate(loadings):
        var_explained = np.sum(l**2)/l.shape[0]*100
        total_var_explained = np.sum(var_explained)
        var_exp.append(total_var_explained)
        print(
            f"Percentage of variance explained by each factor for the {i+1}-factor solution:\n", var_explained)
        print("Total variance explained:", round(
            total_var_explained, ndigits=2), "%\n")
    return var_exp


if __name__ == "__main__":
    import argparse
    import os

    parser = argparse.ArgumentParser()

    parser.add_argument('path_data', type=str, help="Path to the preprocessed data saved as csv")
    parser.add_argument('levels', type=int, help="How many levels to extract")
    parser.add_argument('out_path', type=str, help="Folder to save the loadings and scores in")

    args = parser.parse_args()

    data = pd.read_csv(args.path_data, index_col='Subject')

    suggested_levels = parallel_analysis(data)

    loadings, scores = hierarchical_fa(data, suggested_levels)

    # save loadings and scores
    for i, (l, s) in enumerate(zip(loadings, scores)):
        num = str(i+1).zfill(2)
        l.to_csv(os.path.join(args.out_path, 'loadings', f'loadings_{num}.csv'))
        s.to_csv(os.path.join(args.out_path, 'scores', f'scores_{num}.csv'))