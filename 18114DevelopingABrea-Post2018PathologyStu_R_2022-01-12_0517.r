setwd("~/Desktop/ARGO/Study work/BreastOverUnder40")

#Clear existing data and graphics
rm(list=ls())
graphics.off()
#Load Hmisc library
library(Hmisc)
#Read Data
data=read.csv('18114DevelopingABrea-Post2018PathologyStu_DATA_2022-01-12_0517.csv')
#Setting Labels

library(dplyr)
library(lubridate)
library(tibble)

data_bilat_right <- data %>% dplyr::filter(side == 3) %>% dplyr::mutate(side = 1)
data_bilat_left <- data %>% dplyr::filter(side == 3) %>% dplyr::mutate(side = 2)

data <- data %>% dplyr::filter(side != 3) %>% bind_rows(data_bilat_right) %>% bind_rows(data_bilat_left) %>%
  dplyr::arrange(record_id)

for(i in 1:nrow(data)){
  if(data$side[i] == 1){
    data$fnac[i] <- data$fnac_right[i]
    data$fnac_date[i] <- data$fnac_date_right[i]
    data$fnac_result[i] <- data$fnac_result_right[i]
    data$trucut[i] <- data$trucut_right[i]
    data$trucut_date[i] <- data$trucut_date_right[i]
    data$trucut_result[i] <- data$trucut_result_right[i]
    data$trucut_result_other[i] <- data$trucut_result_other_right[i]
    data$incision_biop[i] <- data$incision_biop_right[i]
    data$incision_biop_date[i] <- data$incision_biop_date_right[i]
    data$incision_biop_result[i] <- data$incision_biop_result_right[i]
    data$incision_biop_result_other[i] <- data$incision_biop_result_other_right[i]
    data$excision[i] <- data$excision_right[i]
    data$excision_date[i] <- data$excision_date_right[i]
    data$excision_result[i] <- data$excision_result_right[i]
    data$excision_result_other[i] <- data$excision_result_other_right[i]
    data$date_histo_diagnosis[i] <- data$date_histo_diagnosis_right[i]
    data$nottingham[i] <- data$nottingham_right[i]
    data$path_stage_t[i] <- data$path_stage_t_right[i]
    data$path_stage_n[i] <- data$path_stage_n_right[i]
    data$path_stage_m[i] <- data$path_stage_m_right[i]
    data$path_stage_group[i] <- data$path_stage_group_right[i]
  }
  if(data$side[i] == 2){
    data$fnac[i] <- data$fnac_left[i]
    data$fnac_date[i] <- data$fnac_date_left[i]
    data$fnac_result[i] <- data$fnac_result_left[i]
    data$trucut[i] <- data$trucut_left[i]
    data$trucut_date[i] <- data$trucut_date_left[i]
    data$trucut_result[i] <- data$trucut_result_left[i]
    data$trucut_result_other[i] <- data$trucut_result_other_left[i]
    data$incision_biop[i] <- data$incision_biop_left[i]
    data$incision_biop_date[i] <- data$incision_biop_date_left[i]
    data$incision_biop_result[i] <- data$incision_biop_result_left[i]
    data$incision_biop_result_other[i] <- data$incision_biop_result_other_left[i]
    data$excision[i] <- data$excision_left[i]
    data$excision_date[i] <- data$excision_date_left[i]
    data$excision_result[i] <- data$excision_result_left[i]
    data$excision_result_other[i] <- data$excision_result_other_left[i]
    data$date_histo_diagnosis[i] <- data$date_histo_diagnosis_left[i]
    data$nottingham[i] <- data$nottingham_left[i]
    data$path_stage_t[i] <- data$path_stage_t_left[i]
    data$path_stage_n[i] <- data$path_stage_n_left[i]
    data$path_stage_m[i] <- data$path_stage_m_left[i]
    data$path_stage_group[i] <- data$path_stage_group_left[i]
  }
}

data <- data %>%
  dplyr::mutate(
    neo_type___1 =
      case_when(neo_type___1 == 1 ~ "CAF"),
    neo_type___2 =
      case_when(neo_type___2 == 1 ~ "CEF"),
    neo_type___3 =
      case_when(neo_type___3 == 1 ~ "CMF"),
    neo_type___4 =
      case_when(neo_type___4 == 1 ~ "EC"),
    neo_type___5 =
      case_when(neo_type___5 == 1 ~ "AC"),
    neo_type___6 =
      case_when(neo_type___6 == 1 ~ "EC/P"),
    neo_type___7 =
      case_when(neo_type___7 == 1 ~ "EC/D"),
    neo_type___8 =
      case_when(neo_type___8 == 1 ~ "GC"),
    neo_type___9 =
      case_when(neo_type___9 == 1 ~ "DC")) %>%
  dplyr::mutate(
    adj_type___1 =
      case_when(adj_type___1 == 1 ~ "CAF"),
    adj_type___2 =
      case_when(adj_type___2 == 1 ~ "CEF"),
    adj_type___3 =
      case_when(adj_type___3 == 1 ~ "CMF"),
    adj_type___4 =
      case_when(adj_type___4 == 1 ~ "EC"),
    adj_type___5 =
      case_when(adj_type___5 == 1 ~ "AC"),
    adj_type___6 =
      case_when(adj_type___6 == 1 ~ "EC/P"),
    adj_type___7 =
      case_when(adj_type___7 == 1 ~ "EC/D"),
    adj_type___8 =
      case_when(adj_type___8 == 1 ~ "GC"),
    adj_type___9 =
      case_when(adj_type___9 == 1 ~ "DC")) %>%
  dplyr::mutate(
    hormone_type___1 =
      case_when(hormone_type___1 == 1 ~ "Tamoxifen"),
    hormone_type___2 =
      case_when(hormone_type___2 == 1 ~ "Anastrazole"),
    hormone_type___3 =
      case_when(hormone_type___3 == 1 ~ "Letrozole"))

data_merged <- data %>% unite(neo_type, neo_type___1:neo_type___9, sep = ",", na.rm = TRUE) %>% 
  mutate(neo_type = ifelse(neo_type=="",NA,neo_type)) %>% 
  unite(adj_type, adj_type___1:adj_type___9, sep = ",", na.rm = TRUE) %>%
  mutate(adj_type = ifelse(adj_type=="",NA,adj_type))  %>% 
  unite(hormone_type, hormone_type___1:hormone_type___3, sep = ",", na.rm = TRUE) %>%
  mutate(hormone_type = ifelse(hormone_type=="",NA,hormone_type)) %>%
  mutate(hospital_number = gsub("\\-*","", hospital_number)) %>% 
  mutate(hospital_number = ifelse(hospital_number=="",NA,hospital_number))

lymph <- read.csv("Lymph.csv") %>% dplyr::rename(hospital_number = Hospital.No) %>% 
  dplyr::mutate(hospital_number = gsub("\\*","", hospital_number)) %>% 
  dplyr::mutate(hospital_number = ifelse(hospital_number=="",NA,hospital_number))

data_merged <- data_merged %>% left_join(lymph, na_matches = "never")

# data_merged %>% dplyr::mutate(age_imputed = interval(as_date(birth_date),as_date(form_date)) / years(1)) %>%
#   dplyr::select(surname, firstname, Patient.s.initials, age_imputed, Age, Date.of.operation, surg_date) %>% View()

#Setting Factors(will create new variable for factors)
data_merged$side.factor = factor(data_merged$side,levels=c("1","2","3"))
data_merged$fnac.factor = factor(data_merged$fnac,levels=c("1","0"))
data_merged$fnac_result.factor = factor(data_merged$fnac_result,levels=c("1","2","3","4","5","0","-1"))
data_merged$trucut.factor = factor(data_merged$trucut,levels=c("1","0"))
data_merged$trucut_result.factor = factor(data_merged$trucut_result,levels=c("1","2","3","4","5","99","-1"))
data_merged$incision_biop.factor = factor(data_merged$incision_biop,levels=c("1","0"))
data_merged$incision_biop_result.factor = factor(data_merged$incision_biop_result,levels=c("1","2","3","4","5","99","-1"))
data_merged$excision.factor = factor(data_merged$excision,levels=c("1","0"))
data_merged$excision_result.factor = factor(data_merged$excision_result,levels=c("1","2","3","4","5","99","-1"))
data_merged$nottingham.factor = factor(data_merged$nottingham,levels=c("1","2","3","4"))
data_merged$path_stage_t.factor = factor(data_merged$path_stage_t,levels=c("1","2","3","4"))
data_merged$path_stage_n.factor = factor(data_merged$path_stage_n,levels=c("0","1","2"))
data_merged$path_stage_m.factor = factor(data_merged$path_stage_m,levels=c("0","1"))
data_merged$path_stage_group.factor = factor(data_merged$path_stage_group,levels=c("1","2","3","4"))
data_merged$ihc.factor = factor(data_merged$ihc,levels=c("1","0","-1"))
data_merged$ihc_er.factor = factor(data_merged$ihc_er,levels=c("1","0"))
data_merged$ihc_pr.factor = factor(data_merged$ihc_pr,levels=c("1","0"))
data_merged$ihc_her2.factor = factor(data_merged$ihc_her2,levels=c("1","0","99"))
data_merged$molecular_type.factor = factor(data_merged$molecular_type,levels=c("1","2","3","4"))
data_merged$neo_chemo.factor = factor(data_merged$neo_chemo,levels=c("1","0"))
data_merged$surgery.factor = factor(data_merged$surgery,levels=c("1","0","-1"))
data_merged$surg_type.factor = factor(data_merged$surg_type,levels=c("0","1","2"))
data_merged$adj_chemo.factor = factor(data_merged$adj_chemo,levels=c("1","0","-1"))
data_merged$hormone.factor = factor(data_merged$hormone,levels=c("1","0","-1"))
data_merged$her2_target_therapy.factor = factor(data_merged$her2_target_therapy,levels=c("1","0"))
data_merged$radiotherapy.factor = factor(data_merged$radiotherapy,levels=c("1","0","-1"))
data_merged$follow_up_status.factor = factor(data_merged$follow_up_status,levels=c("1","2","3","99"))

levels(data_merged$side.factor)=c("Right","Left","Bilateral")
levels(data_merged$fnac.factor)=c("Yes","No")
levels(data_merged$fnac_result.factor)=c("Malignant Cells","Suspicious of Malignancy","Inconclusive","Negative","Benign","N/A","Unknown")
levels(data_merged$trucut.factor)=c("Yes","No")
levels(data_merged$trucut_result.factor)=c("DCIS","Infiltrating Ductal Carcinoma","LCIS","Infiltrating Lobular Carcinoma","Benign","Other","Unknown")
levels(data_merged$incision_biop.factor)=c("Yes","No")
levels(data_merged$incision_biop_result.factor)=c("DCIS","Infiltrating Ductal Carcinoma","LCIS","Infiltrating Lobular Carcinoma","Benign","Other","Unknown")
levels(data_merged$excision.factor)=c("Yes","No")
levels(data_merged$excision_result.factor)=c("DCIS","Infiltrating Ductal Carcinoma","LCIS","Infiltrating Lobular Carcinoma","Benign","Other","Unknown")
levels(data_merged$nottingham.factor)=c("1","2","3","Not Reported")
levels(data_merged$path_stage_t.factor)=c("1","2","3","4")
levels(data_merged$path_stage_n.factor)=c("0","1","2")
levels(data_merged$path_stage_m.factor)=c("0","1")
levels(data_merged$path_stage_group.factor)=c("I","II","III","IV")
levels(data_merged$ihc.factor)=c("Yes","No","Unknown")
levels(data_merged$ihc_er.factor)=c("Positive","Negative")
levels(data_merged$ihc_pr.factor)=c("Positive","Negative")
levels(data_merged$ihc_her2.factor)=c("Yes","No","Not performed")
levels(data_merged$molecular_type.factor)=c("Luminal A (ER + and/or PR +, HER-2 -)","Luminal B (ER + and/or PR +, HER-2 +)","HER-2 (ER and PR -, HER-2 +)","Basal-like (ER/PR -, HER-2 -)")
levels(data_merged$neo_chemo.factor)=c("Yes","No")
levels(data_merged$surgery.factor)=c("Yes","No","Unknown")
levels(data_merged$surg_type.factor)=c("None","Mastectomy","Lumpectomy")
levels(data_merged$adj_chemo.factor)=c("Yes","No","Unknown")
levels(data_merged$hormone.factor)=c("Yes","No","Unknown")
levels(data_merged$her2_target_therapy.factor)=c("Yes","No")
levels(data_merged$radiotherapy.factor)=c("Yes","No","Unknown")
levels(data_merged$follow_up_status.factor)=c("Alive with Disease","Alive and No Evidence of Disease","Dead","Unknown/Defaulted")

#select and order--make csv/excel
data_final <- data_merged %>% 
  add_column(
    tumour_size = NA,
    location.quadrant = NA,
    histological_type = NA,
    histological_grade = NA,
    margins = NA,
    lymph_nodes_harvested = NA,
    lymph_nodes_positive = NA,
    stage = NA,
    pathological_response = NA,
    DCIS = NA,
    LVI = NA) %>%
  dplyr::select(record_id,
  surname,
  firstname,
  hospital_number,
  form_date,
  Pathology.No,       
  Date.of.histopathology.report,
  Type.of.operation.performed,
  Location.of.tumor,
  Size.of.the.tumor,        
  Specimen.tagged,
  Margin.status,
  Number.of.lymph.nodes.harvested,
  Number.of.lymph.nodes.positive,
  T.stage.assigned,
  N.stage.assigned,
  Histopathological.diagnosis,
  Tumour.grade,      
  Immunohistochemistry,  
  tumour_size,
  location.quadrant,
  histological_type,
  histological_grade,
  margins,
  lymph_nodes_harvested,
  lymph_nodes_positive,
  stage,
  pathological_response,
  DCIS,
  LVI,
  side,
  form_date,
  birth_date,
  age,
  fnac = fnac.factor,
  fnac_date,
  fnac_result = fnac_result.factor,
  trucut = trucut.factor,
  trucut_date,
  trucut_result = trucut_result.factor,
  trucut_result_other,
  incision_biop = incision_biop.factor,
  incision_biop_date,
  incision_biop_result = incision_biop_result.factor,
  incision_biop_result_other,
  excision = excision.factor,
  excision_date,
  excision_result = excision_result.factor,
  excision_result_other,
  date_histo_diagnosis,
  nottingham = nottingham.factor,
  path_stage_t = path_stage_t.factor,
  path_stage_n = path_stage_n.factor,
  path_stage_m = path_stage_m.factor,
  path_stage_group = path_stage_group.factor,
  ihc = ihc.factor,
  date_ihc_requested,
  ihc_diagnosis_date,
  ihc_er = ihc_er.factor,
  ihc_pr = ihc_pr.factor,
  ihc_her2 = ihc_her2.factor,
  molecular_type = molecular_type.factor,
  neo_chemo = neo_chemo.factor,
  neo_type,
  neo_cycles_completed,
  surgery = surgery.factor,
  date_surg_recc,
  surg_date,
  surg_type = surg_type.factor,
  adj_chemo = adj_chemo.factor,
  adj_type,
  adj_cycles_completed,
  hormone = hormone.factor,
  hormone_type,
  hormone_duration,
  her2_target_therapy = her2_target_therapy.factor,
  radiotherapy = radiotherapy.factor,
  radio_courses_number,
  radio_dose,
  followup_date,
  follow_up_status = follow_up_status.factor,
  death_date)

label(data_final$record_id)="Participant Research Number (RedCap Number)"
label(data_final$surname)="Surname "
label(data_final$firstname)="First name "
label(data_final$hospital_number)="Hospital Number "
label(data_final$side)="Breast Side "
label(data_final$form_date)="Date form completed"
label(data_final$birth_date)="Date of Birth"
label(data_final$age)="Age"
label(data_final$fnac)="FNAC?"
label(data_final$fnac_date)="FNAC Date"
label(data_final$fnac_result)="FNAC Result"
label(data_final$trucut)="Tru-cut?"
label(data_final$trucut_date)="Tru-cut Date"
label(data_final$trucut_result)="Tru-cut Result"
label(data_final$trucut_result_other)="Other tru-cut result"
label(data_final$incision_biop)="Wedge/Incisional Biopsy"
label(data_final$incision_biop_date)="Incisional Biopsy Date"
label(data_final$incision_biop_result)="Incisional Biopsy Result"
label(data_final$incision_biop_result_other)="Other Incisional Biopsy Result"
label(data_final$excision)="Excisional Biopsy"
label(data_final$excision_date)="Excisional Biopsy Date"
label(data_final$excision_result)="Excisional Biopsy Result"
label(data_final$excision_result_other)="Other Excisional Biopsy Result"
label(data_final$date_histo_diagnosis)="Date histopathological diagnosis made"
label(data_final$nottingham)="Nottingham Grade"
label(data_final$result_benign)="Is result benign?"
label(data_final$path_stage_t)="T:"
label(data_final$path_stage_n)="N:"
label(data_final$path_stage_m)="M:"
label(data_final$path_stage_group)="Stage Grouping"
label(data_final$ihc)="Immunohistochemistry?"
label(data_final$date_ihc_requested)="Date immunohistochemistry was requested "
label(data_final$ihc_diagnosis_date)="Date immunohistochemistry diagnosis made"
label(data_final$ihc_er)="ER"
label(data_final$ihc_pr)="PR"
label(data_final$ihc_her2)="HER2/2neu overexpression"
label(data_final$molecular_type)="Molecular Subtype"
label(data_final$neo_chemo)="Neoadjuvant chemotherapy "
label(data_final$neo_type)="Neoadjuvant chemotherapy agents used"
label(data_final$neo_cycles_completed)="Cycles completed "
label(data_final$surgery)="Any surgical intervention?"
label(data_final$date_surg_recc)="Date recommended"
label(data_final$surg_date)="Date of operation"
label(data_final$surg_type)="Breast Surgery Type"
label(data_final$adj_chemo)="Adjuvant chemotherapy"
label(data_final$adj_type)="Adjuvant chemotherapy agents used"
label(data_final$adj_cycles_completed)="Cycles completed"
label(data_final$hormone)="Hormonal therapy "
label(data_final$hormone_type)="Hormonal Agent used"
label(data_final$hormone_duration)="Duration of Hormonal Therapy (Months)"
label(data_final$her2_target_therapy)="HER-2 Targeted Therapy  "
label(data_final$radiotherapy)="Radiotherapy"
label(data_final$radio_courses_number)="Number of courses "
label(data_final$radio_dose)="Dose of  radiotherapy "
label(data_final$followup_date)="Date of Last follow up   Last contact between patient and staff.  This is NOT date of death. "
label(data_final$follow_up_status)="Status at last follow up"
label(data_final$death_date)="Date of death"

write.csv(data_final, "Breast_post-2018.csv", na = "")

write.csv(Hmisc::label(data_final), "Breast_post-2018_labels.csv")
