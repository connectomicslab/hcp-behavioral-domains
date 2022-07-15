library(lavaan)
library(foreign)

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
    args[1] = "data/03_processed/test_preprocessed.csv"
}

data <- read.csv(args[1], row.names='Subject')

# print('4-factor model')

# model_4f <- 'factor1 =~ PSQI_Score+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_A+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ PainIntens_RawScore+ PainInterf_Tscore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
# factor2 =~ MMSE_Score+ PicSeq_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ IWRD_TOT+ ListSort_Unadj+ ER40_CR+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Math_Acc+ Relational_Task_Match_Acc+ Relational_Task_Rel_Acc+ Social_Task_TOM_Perc_TOM+ WM_Task_Acc+ Endurance_Unadj+ Dexterity_Unadj+ NEOFAC_O+ Noise_Comp+ Taste_Unadj+ Num_Days_Used_Any_Tobacco_7days
# factor3 =~ CardSort_Unadj+ Flanker_Unadj+ ProcSpeed_Unadj+ VSPLOT_CRTE+ SCPT_TPRT+ IWRD_RTC+ ER40_CRT+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Median_RT+ GaitSpeed_Comp
# factor4 =~ Strength_Unadj+ Odor_Unadj+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

# fit_4f <- cfa(model_4f, data = data, std.lv=TRUE)
# summary(fit_4f, fit.measures = TRUE, standardized = TRUE)

# print('5-factor model')

# model_5f <- 'factor1 =~ AngHostil_Unadj+ AngAggr_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_A+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ DSM_Avoid_Raw
# factor2 =~ MMSE_Score+ PicSeq_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ IWRD_TOT+ ListSort_Unadj+ ER40_CR+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Math_Acc+ Relational_Task_Match_Acc+ Relational_Task_Rel_Acc+ Social_Task_TOM_Perc_TOM+ WM_Task_Acc+ Endurance_Unadj+ Dexterity_Unadj+ NEOFAC_O+ Noise_Comp+ Taste_Unadj+ Num_Days_Used_Any_Tobacco_7days
# factor3 =~ PSQI_Score+ AngAffect_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
# factor4 =~ CardSort_Unadj+ Flanker_Unadj+ ProcSpeed_Unadj+ VSPLOT_CRTE+ SCPT_TPRT+ IWRD_RTC+ ER40_CRT+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Median_RT+ GaitSpeed_Comp
# factor5 =~ Strength_Unadj+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

# fit_5f <- cfa(model_5f, data = data, std.lv=TRUE)
# summary(fit_5f, fit.measures = TRUE, standardized = TRUE)

# print('HCP model')

# model_hcp <- 'Alertness =~ MMSE_Score+ PSQI_Score
# Cognition =~ PicSeq_Unadj+ CardSort_Unadj+ Flanker_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj
# Emotion =~ ER40_CR+ ER40_CRT+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj
# In Scanner Task Performance =~ Emotion_Task_Face_Acc+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Acc+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Acc+ WM_Task_Median_RT
# Motor =~ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj
# Personality =~ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E
# Sensory =~ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj
# Psychiatric and Life Function =~ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
# Substance Use =~ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

# fit_hcp <- cfa(model_hcp, data = data, std.lv=TRUE)
# summary(fit_hcp, fit.measures = TRUE, standardized = TRUE)

# print('5-factor hierarchical model')

# model_5f_2f <- 'factor1 =~ AngHostil_Unadj+ AngAggr_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_A+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ DSM_Avoid_Raw
# factor2 =~ MMSE_Score+ PicSeq_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ IWRD_TOT+ ListSort_Unadj+ ER40_CR+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Math_Acc+ Relational_Task_Match_Acc+ Relational_Task_Rel_Acc+ Social_Task_TOM_Perc_TOM+ WM_Task_Acc+ Endurance_Unadj+ Dexterity_Unadj+ NEOFAC_O+ Noise_Comp+ Taste_Unadj+ Num_Days_Used_Any_Tobacco_7days
# factor3 =~ PSQI_Score+ AngAffect_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
# factor4 =~ CardSort_Unadj+ Flanker_Unadj+ ProcSpeed_Unadj+ VSPLOT_CRTE+ SCPT_TPRT+ IWRD_RTC+ ER40_CRT+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Median_RT+ GaitSpeed_Comp
# factor5 =~ Strength_Unadj+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used
#                 emotion   =~ 1*factor1 + 1*factor3 + 1*factor4
#                 cognition =~ 1*factor2 + 1*factor5'

# fit_5f_2f <- cfa(model_5f_2f, data = data, std.lv=TRUE)
# summary(fit_5f_2f, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, threshold = .10')

# model_5f_10 <- 'factor1 =~ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_40K+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_A+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ PainIntens_RawScore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives
# factor2 =~ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ CardSort_Unadj+ Flanker_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ AngAggr_Unadj+ FearAffect_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Acc+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ WM_Task_Acc+ WM_Task_Median_RT+ Endurance_Unadj+ Dexterity_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor3 =~ PSQI_Score+ DDisc_AUC_200+ ListSort_Unadj+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Language_Task_Math_Acc+ WM_Task_Acc+ Endurance_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ PainIntens_RawScore+ PainInterf_Tscore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History
# factor4 =~ MMSE_Score+ PicSeq_Unadj+ CardSort_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ PicVocab_Unadj+ ProcSpeed_Unadj+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_TPRT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ Loneliness_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Acc+ WM_Task_Median_RT+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ NEOFAC_C+ NEOFAC_E+ PainIntens_RawScore+ DSM_Depr_Raw+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives
# factor5 =~ MMSE_Score+ PSQI_Score+ AngAffect_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ SelfEff_Unadj+ Strength_Unadj+ NEOFAC_O+ NEOFAC_C+ Taste_Unadj+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

# fit_5f_10 <- cfa(model_5f_10, data = data, std.lv=TRUE)
# summary(fit_5f_10, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, threshold = .30')

# model_5f_30 <- 'factor1 =~ AngAffect_Unadj+ AngHostil_Unadj+ FearAffect_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_A+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Avoid_Raw
# factor2 =~ MMSE_Score+ PicSeq_Unadj+ CardSort_Unadj+ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_OFF+ SCPT_SPEC+ IWRD_TOT+ ListSort_Unadj+ ER40_CR+ Language_Task_Story_Acc+ Language_Task_Math_Acc+ Relational_Task_Match_Acc+ Relational_Task_Rel_Acc+ Social_Task_TOM_Perc_TOM+ WM_Task_Acc+ Endurance_Unadj+ Dexterity_Unadj+ NEOFAC_O+ Noise_Comp+ Num_Days_Used_Any_Tobacco_7days
# factor3 =~ PSQI_Score+ AngAffect_Unadj+ AngHostil_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ PercHostil_Unadj+ PercStress_Unadj+ NEOFAC_N+ PainIntens_RawScore+ PainInterf_Tscore+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw
# factor4 =~ CardSort_Unadj+ Flanker_Unadj+ ProcSpeed_Unadj+ VSPLOT_CRTE+ SCPT_TPRT+ IWRD_RTC+ ER40_CRT+ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Median_RT+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Median_RT_TOM+ WM_Task_Acc+ WM_Task_Median_RT
# factor5 =~ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used'

# fit_5f_30 <- cfa(model_5f_30, data = data, std.lv=TRUE)
# summary(fit_5f_30, fit.measures = TRUE, standardized = TRUE)

# print('4 Factors, top 10')

# model_4f_t10 <- 'factor1 =~ Sadness_Unadj+ PercStress_Unadj+ NEOFAC_N+ Loneliness_Unadj+ DSM_Depr_Raw+ DSM_Anxi_Raw+ AngAffect_Unadj+ FearAffect_Unadj+ DSM_Avoid_Raw+ PercReject_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ Language_Task_Math_Acc+ PMAT24_A_RTCR+ VSPLOT_OFF+ Endurance_Unadj+ ListSort_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days
# factor3 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ ProcSpeed_Unadj+ Social_Task_TOM_Median_RT_TOM+ ER40_CRT+ Relational_Task_Rel_Median_RT+ Flanker_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days
# factor4 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ SSAGA_Mj_Times_Used+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_Alc_D4_Dp_Sx+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days'

# fit_4f_t10 <- cfa(model_4f_t10, data = data, std.lv=TRUE)
# summary(fit_4f_t10, fit.measures = TRUE, standardized = TRUE)

# print('4 Factors, top 5')

# model_4f_t5 <- 'factor1 =~ Sadness_Unadj+ PercStress_Unadj+ NEOFAC_N+ Loneliness_Unadj+ DSM_Depr_Raw+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor3 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor4 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngAffect_Unadj+ AngHostil_Unadj+ AngAggr_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used'

# fit_4f_t5 <- cfa(model_4f_t5, data = data, std.lv=TRUE)
# summary(fit_4f_t5, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, top 10')

# model_5f_t10 <- 'factor1 =~ Loneliness_Unadj+ EmotSupp_Unadj+ Friendship_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ LifeSatisf_Unadj+ PercReject_Unadj+ PercStress_Unadj+ NEOFAC_E+ NEOFAC_N+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ PercHostil_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Avoid_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ Language_Task_Math_Acc+ PMAT24_A_RTCR+ VSPLOT_OFF+ Endurance_Unadj+ ListSort_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ PercHostil_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Avoid_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx
# factor3 =~ DSM_Anxi_Raw+ DSM_Depr_Raw+ FearAffect_Unadj+ AngAffect_Unadj+ DSM_Adh_Raw+ DSM_Somp_Raw+ FearSomat_Unadj+ Sadness_Unadj+ NEOFAC_N+ PercStress_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ PercHostil_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Avoid_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx
# factor4 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ ProcSpeed_Unadj+ ER40_CRT+ Social_Task_TOM_Median_RT_TOM+ Relational_Task_Rel_Median_RT+ Flanker_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ PercHostil_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Avoid_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx
# factor5 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ SSAGA_Mj_Times_Used+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ Num_Days_Used_Any_Tobacco_7days+ Num_Days_Drank_7days+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ER40_CR+ AngHostil_Unadj+ AngAggr_Unadj+ PercHostil_Unadj+ InstruSupp_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Social_Task_TOM_Perc_TOM+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Avoid_Raw+ DSM_Antis_Raw+ SSAGA_Alc_D4_Dp_Sx'

# fit_5f_t10 <- cfa(model_5f_t10, data = data, std.lv=TRUE)
# summary(fit_5f_t10, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, top 5')

# model_5f_t5 <- 'factor1 =~ Loneliness_Unadj+ EmotSupp_Unadj+ Friendship_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor3 =~ DSM_Anxi_Raw+ DSM_Depr_Raw+ FearAffect_Unadj+ AngAffect_Unadj+ DSM_Adh_Raw+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor4 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used
# factor5 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ MMSE_Score+ PSQI_Score+ PicSeq_Unadj+ Flanker_Unadj+ PMAT24_A_RTCR+ ProcSpeed_Unadj+ DDisc_AUC_200+ DDisc_AUC_40K+ VSPLOT_CRTE+ VSPLOT_OFF+ SCPT_SEN+ SCPT_SPEC+ SCPT_TPRT+ IWRD_TOT+ IWRD_RTC+ ListSort_Unadj+ ER40_CR+ ER40_CRT+ AngHostil_Unadj+ AngAggr_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ InstruSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ Emotion_Task_Face_Acc+ Emotion_Task_Shape_Acc+ Language_Task_Story_Acc+ Language_Task_Story_Median_RT+ Language_Task_Math_Acc+ Language_Task_Math_Median_RT+ Relational_Task_Match_Acc+ Relational_Task_Rel_Median_RT+ Social_Task_TOM_Perc_TOM+ Social_Task_TOM_Median_RT_TOM+ Endurance_Unadj+ GaitSpeed_Comp+ Dexterity_Unadj+ Strength_Unadj+ NEOFAC_A+ NEOFAC_O+ NEOFAC_C+ NEOFAC_N+ NEOFAC_E+ Noise_Comp+ Odor_Unadj+ PainIntens_RawScore+ PainInterf_Tscore+ Taste_Unadj+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Antis_Raw+ Num_Days_Drank_7days+ SSAGA_Alc_D4_Dp_Sx+ SSAGA_Alc_D4_Ab_Sx+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_TB_Smoking_History+ SSAGA_Mj_Times_Used'

# fit_5f_t5 <- cfa(model_5f_t5, data = data, std.lv=TRUE)
# summary(fit_5f_t5, fit.measures = TRUE, standardized = TRUE)

# # old code, letting only the indicators relate to each factor, instead of restricting only the indicators

# print('4 Factors, top 10 only')

# model_4f_t10 <- 'factor1 =~ Sadness_Unadj+ PercStress_Unadj+ NEOFAC_N+ Loneliness_Unadj+ DSM_Depr_Raw+ DSM_Anxi_Raw+ AngAffect_Unadj+ FearAffect_Unadj+ DSM_Avoid_Raw+ PercReject_Unadj
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ Language_Task_Math_Acc+ PMAT24_A_RTCR+ VSPLOT_OFF+ Endurance_Unadj+ ListSort_Unadj
# factor3 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ ProcSpeed_Unadj+ Social_Task_TOM_Median_RT_TOM+ ER40_CRT+ Relational_Task_Rel_Median_RT+ Flanker_Unadj
# factor4 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ SSAGA_Mj_Times_Used+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ Num_Days_Used_Any_Tobacco_7days+ SSAGA_Alc_D4_Dp_Sx'

# fit_4f_t10 <- cfa(model_4f_t10, data = data, std.lv=TRUE)
# summary(fit_4f_t10, fit.measures = TRUE, standardized = TRUE)

# print('4 Factors, top 5 only')

# model_4f_t5 <- 'factor1 =~ Sadness_Unadj+ PercStress_Unadj+ NEOFAC_N+ Loneliness_Unadj+ DSM_Depr_Raw
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc
# factor3 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj
# factor4 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates'

# fit_4f_t5 <- cfa(model_4f_t5, data = data, std.lv=TRUE)
# summary(fit_4f_t5, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, top 10 only')

# model_5f_t10 <- 'factor1 =~ Loneliness_Unadj+ EmotSupp_Unadj+ Friendship_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ LifeSatisf_Unadj+ PercReject_Unadj+ PercStress_Unadj+ NEOFAC_E+ NEOFAC_N
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc+ Language_Task_Math_Acc+ PMAT24_A_RTCR+ VSPLOT_OFF+ Endurance_Unadj+ ListSort_Unadj
# factor3 =~ DSM_Anxi_Raw+ DSM_Depr_Raw+ FearAffect_Unadj+ AngAffect_Unadj+ DSM_Adh_Raw+ DSM_Somp_Raw+ FearSomat_Unadj+ Sadness_Unadj+ NEOFAC_N+ PercStress_Unadj
# factor4 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj+ ProcSpeed_Unadj+ ER40_CRT+ Social_Task_TOM_Median_RT_TOM+ Relational_Task_Rel_Median_RT+ Flanker_Unadj
# factor5 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates+ SSAGA_Mj_Times_Used+ SSAGA_Alc_D4_Ab_Sx+ SSAGA_TB_Smoking_History+ Num_Days_Used_Any_Tobacco_7days+ Num_Days_Drank_7days'

# fit_5f_t10 <- cfa(model_5f_t10, data = data, std.lv=TRUE)
# summary(fit_5f_t10, fit.measures = TRUE, standardized = TRUE)

# print('5 Factors, top 5 only')

# model_5f_t5 <- 'factor1 =~ Loneliness_Unadj+ EmotSupp_Unadj+ Friendship_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj
# factor2 =~ ReadEng_Unadj+ PMAT24_A_CR+ PicVocab_Unadj+ WM_Task_Acc+ Relational_Task_Rel_Acc
# factor3 =~ DSM_Anxi_Raw+ DSM_Depr_Raw+ FearAffect_Unadj+ AngAffect_Unadj+ DSM_Adh_Raw
# factor4 =~ Emotion_Task_Shape_Median_RT+ Emotion_Task_Face_Median_RT+ WM_Task_Median_RT+ Relational_Task_Match_Median_RT+ CardSort_Unadj
# factor5 =~ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Stimulants+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Opiates'

# fit_5f_t5 <- cfa(model_5f_t5, data = data, std.lv=TRUE)
# summary(fit_5f_t5, fit.measures = TRUE, standardized = TRUE)

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

print('4 Factors, threshold 0.50')

model_4f_t50 <- '
factor1 =~ AngAffect_Unadj+ AngHostil_Unadj+ FearAffect_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercHostil_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ PercStress_Unadj+ NEOFAC_N+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Avoid_Raw+ DSM_Adh_Raw
factor2 =~ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ VSPLOT_OFF+ Language_Task_Math_Acc+ Relational_Task_Rel_Acc+ WM_Task_Acc
factor3 =~ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Relational_Task_Match_Median_RT+ WM_Task_Median_RT
factor4 =~ SSAGA_Alc_D4_Ab_Sx+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used
'

fit_4f_t50 <- cfa(model_4f_t50, data=data, std.lv=TRUE)

summary(fit_4f_t50, fit.measures=TRUE, standardized = TRUE)

print('5 Factors, threshold 0.50')

model_5f_t50 <- '
factor1 =~ AngHostil_Unadj+ Sadness_Unadj+ LifeSatisf_Unadj+ MeanPurp_Unadj+ PosAffect_Unadj+ Friendship_Unadj+ Loneliness_Unadj+ PercReject_Unadj+ EmotSupp_Unadj+ PercStress_Unadj+ SelfEff_Unadj+ NEOFAC_N+ NEOFAC_E+ DSM_Avoid_Raw
factor2 =~ PMAT24_A_CR+ PMAT24_A_RTCR+ ReadEng_Unadj+ PicVocab_Unadj+ VSPLOT_OFF+ Language_Task_Math_Acc+ Relational_Task_Rel_Acc+ WM_Task_Acc
factor3 =~ AngAffect_Unadj+ FearAffect_Unadj+ FearSomat_Unadj+ Sadness_Unadj+ DSM_Depr_Raw+ DSM_Anxi_Raw+ DSM_Somp_Raw+ DSM_Adh_Raw
factor4 =~ Emotion_Task_Face_Median_RT+ Emotion_Task_Shape_Median_RT+ Relational_Task_Match_Median_RT+ WM_Task_Median_RT
factor5 =~ SSAGA_Alc_D4_Ab_Sx+ SSAGA_Times_Used_Cocaine+ SSAGA_Times_Used_Hallucinogens+ SSAGA_Times_Used_Opiates+ SSAGA_Times_Used_Sedatives+ SSAGA_Times_Used_Stimulants+ SSAGA_Mj_Times_Used
'

fit_5f_t50 <- cfa(model_5f_t50, data=data, std.lv=TRUE)

summary(fit_5f_t50, fit.measures=TRUE, standardized = TRUE)