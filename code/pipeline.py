import os

from processing.preprocessing import collect_data, impute_missing, regress_confounders, invert_columns, z_score

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument('path_unr', type=str)
    parser.add_argument('path_res', type=str)
    parser.add_argument('path_subjects', type=str)
    # parser.add_argument('path_col_unr', type=str)
    # parser.add_argument('path_col_res', type=str)
    # parser.add_argument('path_rt_cols', type=str)
    parser.add_argument('--out_path', '-o', type=str)
    parser.add_argument('--filename', type=str)

    args = parser.parse_args()
    # path_unr = "../../data/01_inputs/hcp_behavioral.csv"
    # path_res = "../../data/01_inputs/hcp_behavioral_RESTRICTED.csv"
    # path_subjects = "../data/02_intermediate/train_subjects.csv"
    path_col_unr = "../../data/02_intermediate/col_unr.csv"
    path_col_res = "../../data/02_intermediate/col_res.csv"
    path_rt_cols = "../../data/02_intermediate/rt_cols.csv"

    data = collect_data(args.path_unr, args.path_res, args.path_subjects, args.path_col_unr, args.path_col_res,
                        args.out_path, args.filename)
    data_imputed = impute_missing(data, args.out_path, args.filename)
    data_res = regress_confounders(data_imputed, args.path_unr, args.path_res, args.out_path, args.filename)
    data_inv = invert_columns(data_res, args.path_rt_cols, args.out_path, args.filename)
    data_z = z_score(data_inv, args.out_path, args.filename)
    data_z.to_csv(os.path.join(args.out_path, '..', '03_processed', f'{args.filename}_preprocessed.csv'))
