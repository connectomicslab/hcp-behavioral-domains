import os
import pandas as pd
import numpy as np
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer
from sklearn.linear_model import LinearRegression


def collect_data(path_unr, path_res, path_subjects, path_col_unr, path_col_res, out_path=None, filename='data'):
    """Collects the relevant variables from the HCP behavioral data and saves them as a csv file.

    Parameters
    ----------
    path_unr : str
        Path to the unrestricted data saved as csv
    path_res : str
        Path to the restricted data saved as csv
    path_subjects : str
        Path to list of subjects to load saved as csv
    path_col_unr : str
        Path to list of columns to load from the unrestricted data saved as csv
    path_col_res : str
        Path to list of columns to load from the restricted data saved as csv
    out_path : str, optional
        Filepath to save csv with data to, by default None
    filename : str, optional
        Filename to save csv with data, by default 'data'

    Returns
    -------
    DataFrame
        Collected data as pandas dataframe
    """
    # Read in csv to dataframe
    data_unr = pd.read_csv(path_unr, index_col="Subject")
    data_res = pd.read_csv(path_res, index_col="Subject")
    # Read column csv
    col_unr = pd.read_csv(path_col_unr, header=None).to_numpy().T[0]
    col_res = pd.read_csv(path_col_res, header=None).to_numpy().T[0]
    # Get only subjects with complete scanner data
    subject_ids = pd.read_csv(path_subjects, header=None).to_numpy().T[0]
    data_unr_subjects = data_unr.loc[subject_ids]
    data_res_subjects = data_res.loc[subject_ids]
    # Concatenate unrestricted and restricted data
    data = pd.concat([data_unr_subjects[col_unr], data_res_subjects[col_res]], axis=1)
    if out_path != None:
        data.to_csv(os.path.join(out_path, f"01_{filename}_fa.csv"))
    return data

def impute_missing(data, out_path=None, filename='data'):
    """Takes the data as pandas dataframe, imputes using the MICE algorithm, returns imputed dataset.

    Parameters
    ----------
    data : DataFrame
        Dataset to impute
    out_path : str, optional
        Filepath to save csv with data to, by default None
    filename : str, optional
        Filename for data csv, by default 'data'

    Returns
    -------
    DataFrame
        Imputed data as pandas dataframe
    """
    imputer = IterativeImputer(max_iter=100)
    data_np = imputer.fit_transform(data)
    # convert back to DataFrame
    data_imputed = pd.DataFrame(data_np, index=data.index, columns=data.columns)
    # save data
    if out_path != None:
        data_imputed.to_csv(os.path.join(out_path, f"02_{filename}_imputed.csv"))
    return data_imputed

def regress_confounders(data, path_unr, path_res, out_path=None, filename='data'):
    """Takes the data as pandas dataframe, regresses out age and gender, returns residuals as dataframe.

    Parameters
    ----------
    data : DataFrame
        Dataset to regress
    path_unr : str
        Path to the unrestricted data saved as csv
    path_res : str
        Path to the restricted data saved as csv
    out_path : str, optional
        Filepath to save csv with data to, optional, by default None
    filename : str, optional
        Filename for data csv, by default 'data'

    Returns
    -------
    DataFrame
        Residuals of the regressed dataset
    """
    data_unr = pd.read_csv(path_unr, index_col="Subject")
    data_res = pd.read_csv(path_res, index_col="Subject")
    data_unr_subjects = data_unr.loc[data.index]
    data_res_subjects = data_res.loc[data.index]
    # get age and gender for those subjects
    age = data_res_subjects['Age_in_Yrs'].copy()
    gender = data_unr_subjects['Gender'].copy()
    # lib male as 0 and female as 1
    gender[gender == 'M'] = 0.0
    gender[gender == 'F'] = 1.0
    # matrix of predictors age and gender
    x = np.column_stack((age, gender))
    # z-score variables
    mean = data.mean().values
    sd = data.std().values
    y = ((data-mean)/sd)
    # fit regression model
    reg = LinearRegression().fit(x,y)
    # predict values based on model
    pred = reg.predict(x)
    # residuals: difference between actual and predicted values
    data_res = y-pred
    if out_path != None:
        data_res.to_csv(os.path.join(out_path, f"03_{filename}_res.csv"))
    return data_res

def invert_columns(data, path_cols_inv, out_path=None, filename='data'):
    """Takes the data as pandas dataframe, inverts the given columns, returns dataset as dataframe.

    Parameters
    ----------
    data : DataFrame
        Dataset with columns to invert
    path_cols_inv : DataFrame
        Path to csv containing columns to invert
    out_path : str, optional
        Filepath to save csv with data to, by default None
    filename : str, optional
        Filename for data csv, by default 'data'

    Returns
    -------
    DataFrame
        Dataset with inverted values
    """
    cols_to_invert = pd.read_csv(path_cols_inv, header=None).to_numpy().T[0]
    max_vals = data.loc[:, cols_to_invert].max(axis=0) # maximum value for RT columns
    data_inv = data.copy() # make copy of behavioral data
    data_inv.loc[:, cols_to_invert] = max_vals-data.loc[:, cols_to_invert] # invert RT
    if out_path != None:
        data_inv.to_csv(os.path.join(out_path, f"04_{filename}_inv.csv"))
    return data_inv

def z_score(data, out_path=None, filename='data'):
    """Z-scores data

    Parameters
    ----------
    data : DataFrame
        Dataset to z-score
    out_path : str, optional
        Filepath to save csv with data to, by default None
    filename : str, optional
        Filename for data csv, by default 'data'

    Returns
    -------
    DataFrame
        Dataset with z-scored values
    """
    # z-score variables
    mean = data.mean().values
    sd = data.std().values
    data_z = ((data-mean)/sd)
    if out_path != None:
        data_z.to_csv(os.path.join(out_path, f"05_{filename}_z.csv"))
    return data_z

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument('path_unr', type=str, help="Path to the unrestricted data saved as csv")
    parser.add_argument('path_res', type=str, help="Path to the restricted data saved as csv")
    parser.add_argument('path_subjects', type=str, help="Path to the subject list")
    parser.add_argument('path_col_unr', type=str, help="Path to the list of variables from the unrestricted data")
    parser.add_argument('path_col_res', type=str, help="Path to the list of variables from the unrestricted data")
    parser.add_argument('path_rt_cols', type=str, help="Path to the list of variables to invert")
    parser.add_argument('--out_path', '-o', type=str, help="Folder to save the preprocessed data in")
    parser.add_argument('--filename', type=str, help="Filename for saving the preprocessed data")

    args = parser.parse_args()

    data = collect_data(args.path_unr, args.path_res, args.path_subjects, args.path_col_unr, args.path_col_res,
                        args.out_path, args.filename)
    data_imputed = impute_missing(data, args.out_path, args.filename)
    data_res = regress_confounders(data_imputed, args.path_unr, args.path_res, args.out_path, args.filename)
    data_inv = invert_columns(data_res, args.path_rt_cols, args.out_path, args.filename)
    data_z = z_score(data_inv, args.out_path, args.filename)
    data_z.to_csv(os.path.join(args.out_path, '..', '03_processed', f'{args.filename}_preprocessed.csv'))