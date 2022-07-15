import pandas as pd
import numpy as np
from factor_analyzer import ConfirmatoryFactorAnalyzer, ModelSpecificationParser


def specification_array(loadings):
    """
    Creates array to use as specification for the CFA.

    The maximum of the absolute loading per variable
    is set to 1, loadings on all other factors are set
    to 0.
    """
    abs_loadings = np.abs(loadings.to_numpy())
    max_indices = np.argmax(abs_loadings, axis=1)
    specification = np.zeros_like(abs_loadings)
    for i, idx in enumerate(max_indices):
        specification[i, idx] = 1
    return specification

def run_cfa(data, loadings):
    spec_array = specification_array(loadings)
    spec = ModelSpecificationParser.parse_model_specification_from_array(data, spec_array.T)
    cfa = ConfirmatoryFactorAnalyzer(spec, max_iter=100000000)
    cfa.fit(loadings.values)