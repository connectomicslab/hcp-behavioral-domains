import os

from processing.preprocessing import collect_data, impute_missing, regress_confounders, invert_columns, z_score
from processing.exploratory_fa import parallel_analysis, hierarchical_fa

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()

    # path to unrestricted data
    parser.add_argument('path_unr', type=str)
    # path to restricted data
    parser.add_argument('path_res', type=str)
    # list of subjects to process
    parser.add_argument('path_subjects', type=str)
    # directory to output the scores and loadings to
    parser.add_argument('out_path', type=str)

    args = parser.parse_args()

    # hard-code relative paths to columns to use and to invert
    path_col_unr = "data/col_unr.csv"
    path_col_res = "data/col_res.csv"
    path_rt_cols = "data/rt_cols.csv"

    # run preprocessing
    data = collect_data(args.path_unr, args.path_res, args.path_subjects, path_col_unr, path_col_res)
    data_imputed = impute_missing(data)
    data_res = regress_confounders(data_imputed, args.path_unr, args.path_res)
    data_inv = invert_columns(data_res, path_rt_cols)
    data_z = z_score(data_inv)

    # run factor analysis
    suggested_levels = parallel_analysis(data_z)
    loadings, scores = hierarchical_fa(data_z, suggested_levels)

    # save loadings and scores
    folders = ["loadings", "scores"]
    for f in folders:
        if os.path.exists(os.path.join(args.out_path, f)) == False:
            os.mkdir(os.path.join(args.out_path, f))
    for i, (l, s) in enumerate(zip(loadings, scores)):
        num = str(i+1).zfill(2)
        l.to_csv(os.path.join(args.out_path, 'loadings', f'loadings_{num}.csv'))
        s.to_csv(os.path.join(args.out_path, 'scores', f'scores_{num}.csv'))