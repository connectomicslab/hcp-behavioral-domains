library(lavaan)
library(foreign)

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
    args[1] = "data/03_processed/test_preprocessed.csv"
}

data <- read.csv(args[1], row.names='Subject')

print('4 Factors, threshold 0.45')

model_4f_t45 <- '
factor1 =~ AngAffect_Unadj+ AngHostil_Unadj+ FearAffect_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_N+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
factor2 =~ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ VSPLOT_OFF+ Language_Task_Math_Acc+ Relational_Task_Rel_Acc+ WM_Task_Acc
factor3 =~ CardSort_Unadj+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Relational_Task_Match_Median_RT+ WM_Task_Median_RT
factor4 =~ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used
'

fit_4f_t45 <- cfa(model_4f_t45, data=data, std.lv=TRUE, estimator='MLR')

summary(fit_4f_t45, fit.measures=TRUE, standardized = TRUE)

print('5 Factors, threshold 0.45')

model_5f_t45 <- 'factor1 =~ AngHostil_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_N+ NEOFAC_E+ DSM_Avoid_Raw
factor2 =~ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ VSPLOT_OFF+ Language_Task_Math_Acc+ Relational_Task_Rel_Acc+ WM_Task_Acc
factor3 =~ AngAffect_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ PercStress_Unadj+ NEOFAC_N+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Adh_Raw
factor4 =~ CardSort_Unadj+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Relational_Task_Match_Median_RT+ WM_Task_Median_RT
factor5 =~ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

fit_5f_t45 <- cfa(model_5f_t45, data=data, std.lv=TRUE, estimator='MLR')

summary(fit_5f_t45, fit.measures=TRUE, standardized = TRUE)