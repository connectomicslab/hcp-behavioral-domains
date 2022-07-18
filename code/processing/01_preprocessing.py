import os
import pandas as pd
import numpy as np
from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import IterativeImputer
from sklearn.linear_model import LinearRegression


def collect_data(path_unr, path_res, path_subjects, path_col_unr, path_col_res, out_path=None, filename='data'):
    """
    Collects the relevant variables from the HCP behavioral data and saves them as a csv file.
    :param path_unr: Path to the unrestricted data saved as csv
    :param path_res: Path to the restricted data saved as csv
    :param path_subjects: Path to list of subjects to load saved as csv
    :param path_col_unr: Path to list of columns to load from the unrestricted data saved as csv
    :param path_col_res: Path to list of columns to load from the restricted data saved as csv
    :param out_path: Filepath to save csv with data to, optional
    :return: Collected data as pandas dataframe
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
    """
    Takes the data as pandas dataframe, imputes using the MICE algorithm, returns imputed dataset.
    :param data: dataset as dataframe
    :param out_path: Filepath to save csv with data to, optional
    :return: Imputed data as pandas dataframe
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
    """
    Takes the data as pandas dataframe, regresses out age and gender, returns residuals as dataframe.
    :param data: dataset as dataframe
    :param path_unr: Path to the unrestricted data saved as csv
    :param path_res: Path to the restricted data saved as csv
    :param out_path: Filepath to save csv with data to, optional
    :return: Residuals as pandas dataframe
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
    """
    Takes the data as pandas dataframe, inverts the given columns, returns dataset as dataframe.
    :param data: Dataset as dataframe
    :param path_cols_inv: Path to csv containing columns to invert
    :param out_path: Filepath to save csv with data to, optional
    :return: Dataset with inverted values as pandas dataframe
    """
    cols_to_invert = pd.read_csv(path_cols_inv, header=None).to_numpy().T[0]
    max_vals = data.loc[:, cols_to_invert].max(axis=0) # maximum value for RT columns
    data_inv = data.copy() # make copy of behavioral data
    data_inv.loc[:, cols_to_invert] = max_vals-data.loc[:, cols_to_invert] # invert RT
    if out_path != None:
        data_inv.to_csv(os.path.join(out_path, f"04_{filename}_inv.csv"))
    return data_inv

def z_score(data, out_path=None, filename='data'):
    """
    Z-scores data
    :param data: Dataset as dataframe
    :param out_path: Filepath to save csv with data to, optional
    :return: Dataset with z-scored values as pandas dataframe
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

    parser.add_argument('path_unr', type=str)
    parser.add_argument('path_res', type=str)
    parser.add_argument('path_subjects', type=str)
    parser.add_argument('path_col_unr', type=str)
    parser.add_argument('path_col_res', type=str)
    parser.add_argument('path_rt_cols', type=str)
    parser.add_argument('--out_path', '-o', type=str)
    parser.add_argument('--filename', type=str)

    args = parser.parse_args()
    # path_unr = "../../data/01_inputs/hcp_behavioral.csv"
    # path_res = "../../data/01_inputs/hcp_behavioral_RESTRICTED.csv"
    # path_subjects = "../data/02_intermediate/train_subjects.csv"
    # path_col_unr = "../../data/02_intermediate/col_unr.csv"
    # path_col_res = "../../data/02_intermediate/col_res.csv"
    # path_rt_cols = "../../data/02_intermediate/rt_cols.csv"

    data = collect_data(args.path_unr, args.path_res, args.path_subjects, args.path_col_unr, args.path_col_res,
                        args.out_path, args.filename)
    data_imputed = impute_missing(data, args.out_path, args.filename)
    data_res = regress_confounders(data_imputed, args.path_unr, args.path_res, args.out_path, args.filename)
    data_inv = invert_columns(data_res, args.path_rt_cols, args.out_path, args.filename)
    data_z = z_score(data_inv, args.out_path, args.filename)
    data_z.to_csv(os.path.join(args.out_path, '..', '03_processed', f'{args.filename}_preprocessed.csv'))

    # datalad run -i data/01_inputs/hcp_behavioral.csv -i data/01_inputs/hcp_behavioral_RESTRICTED.csv -i data/02_intermediate/all_subjects.csv -i data/02_intermediate/col_unr.csv -i data/02_intermediate/col_res.csv -i data/02_intermediate/rt_cols.csv -o data/02_intermediate/ -o data/03_processed/ "python code/processing/preprocessing.py data/01_inputs/hcp_behavioral.csv data/01_inputs/hcp_behavioral_RESTRICTED.csv data/02_intermediate/all_subjects.csv data/02_intermediate/col_unr.csv data/02_intermediate/col_res.csv data/02_intermediate/rt_cols.csv --out_path data/02_intermediate --filename all"
