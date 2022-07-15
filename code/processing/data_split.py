import pandas as pd
import os
from sklearn.model_selection import GroupShuffleSplit

def train_test_split(path_res, out_path):
    """
    Creates train and test subsets of the data, making sure that members of the same family are in the same split. Saves
    the subject IDs of the respective subsets as csv files.
    :param path_res: Path to the restricted data saved as csv
    :param out_path: Path to save the csvs to
    :return: Nothing
    """
    data_res = pd.read_csv(path_res)
    gss = GroupShuffleSplit(n_splits=1, test_size=0.5, random_state=42)

    out_train = os.path.join(out_path, 'train_subjects.csv')
    out_test = os.path.join(out_path, 'test_subjects.csv')
    for train_idx, test_idx in gss.split(data_res, data_res['Age_in_Yrs'], groups=data_res['Family_ID']):
        # train_subjects =
        train = data_res['Subject'].iloc[train_idx]
        test = data_res['Subject'].iloc[test_idx]
        train.to_csv(out_train, header=False, index=False)
        test.to_csv(out_test, header=False, index=False)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument('path_res', type=str, help="Path to the restricted data saved as csv")
    parser.add_argument('out_path', type=str, help="Path to save the csvs to")

    args = parser.parse_args()

    train_test_split(args.path_res, args.out_path)