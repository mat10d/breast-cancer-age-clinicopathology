# Breast Cancer in Elderly Patients: Data Processing Pipeline

## Citation

**Wuraola FO, Olasehinde O, Di Bernardo M, Akinkuolie AA, Adisa AO, Aderounmu AA, Mohammed TO, Omoyiola OZ, Kingham TP, Alatise OI (2022)**
Breast cancer in elderly patients: a clinicopathological review of a Nigerian database.
*ecancermedicalscience* 16:1484.
DOI: [10.3332/ecancer.2022.1484](https://doi.org/10.3332/ecancer.2022.1484)

### Authors

| # | Author | Affiliation |
|---|--------|-------------|
| 1 | Funmilola Olanike Wuraola | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 2 | Olalekan Olasehinde | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 3 | Matteo Di Bernardo | Department of Surgery, Memorial Sloan Kettering Cancer Center, New York, USA |
| 4 | Akinbolaji A Akinkuolie | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 5 | Adewale O Adisa | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 6 | Adewale A Aderounmu | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 7 | Tajudeen O Mohammed | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 8 | Oluwatosin Z Omoyiola | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |
| 9 | Thomas P Kingham | Department of Surgery, Memorial Sloan Kettering Cancer Center, New York, USA |
| 10 | Olusegun I Alatise | Department of Surgery, Obafemi Awolowo University Teaching Hospitals Complex, Ile-Ife, Nigeria |

## Overview

> **Important:** This repository contains the **data processing pipeline** for cleaning and transforming the REDCap clinical data export. The statistical analysis reported in the paper (Chi-square tests, Fisher's exact tests, descriptive statistics, survival analysis) was performed using **SPSS** by the clinical research team. This is a common and standard workflow in clinical research.

The R script (`breast_cancer_analysis.R`) takes raw REDCap exports and produces a clean, analysis-ready dataset. It does **not** perform statistical tests or generate the tables/figures presented in the publication.

### What this code does

- Cleans and restructures the REDCap data export
- Handles bilateral breast cancer cases (splits into separate laterality records)
- Consolidates side-specific pathology columns into unified fields
- Converts multi-select checkbox variables to readable strings
- Merges supplementary lymph node data
- Creates labeled factor variables for all categorical data
- Exports a processed CSV ready for statistical analysis

### What this code does NOT do

- Chi-square or Fisher's exact tests (performed in SPSS)
- Descriptive statistics tables (performed in SPSS)
- Survival/follow-up analysis (performed in SPSS)
- Figure generation (performed in SPSS/Excel)

## Repository Structure

```
├── README.md
├── breast_cancer_analysis.R                    # Data processing script (R)
├── 18114DevelopingABrea-...DATA_2022-01-12_0517.csv  # REDCap data export
├── Lymph.csv                                   # Supplementary lymph node data
├── results/                                    # Output directory
│   ├── processed_breast_cancer_data.csv        # Cleaned dataset (generated)
│   └── variable_labels.csv                     # Variable label dictionary (generated)
└── .gitignore
```

## Data Description

### Input Files

| File | Description |
|------|-------------|
| `18114DevelopingABrea-Post2018PathologyStu_DATA_2022-01-12_0517.csv` | Main pathology dataset exported from REDCap (2022-01-12). Contains demographics, diagnostic procedures, pathology results, IHC, treatment, and follow-up data. |
| `Lymph.csv` | Supplementary lymph node assessment data, merged by hospital number. |

### Output Files

| File | Description |
|------|-------------|
| `results/processed_breast_cancer_data.csv` | Cleaned dataset with consolidated pathology fields, labeled factors, and merged lymph node data. Ready for statistical analysis. |
| `results/variable_labels.csv` | Data dictionary mapping each variable to its descriptive label. |

### Key Variables in Processed Dataset

| Category | Variables |
|----------|-----------|
| **Demographics** | `record_id`, `age`, `birth_date`, `side` |
| **Diagnostics** | `fnac`, `fnac_result`, `trucut`, `trucut_result`, `incision_biop`, `excision` |
| **Pathology** | `nottingham` (grade), `path_stage_t/n/m`, `path_stage_group` |
| **IHC** | `ihc_er`, `ihc_pr`, `ihc_her2`, `molecular_type` |
| **Treatment** | `neo_chemo`, `neo_type`, `surgery`, `surg_type`, `adj_chemo`, `adj_type`, `hormone`, `hormone_type`, `radiotherapy` |
| **Outcomes** | `follow_up_status`, `death_date`, `followup_date` |

## Requirements

### R Packages

| Package | Purpose |
|---------|---------|
| **Hmisc** | Variable labeling (`label()`) |
| **dplyr** | Data manipulation (`filter`, `mutate`, `select`) |
| **lubridate** | Date handling |
| **tibble** | `add_column()` for placeholder variables |
| **tidyr** | `unite()` for merging multi-select fields |

The script auto-installs missing packages. To install manually:

```r
install.packages(c("Hmisc", "dplyr", "lubridate", "tibble", "tidyr"))
```

## Usage

```r
# Set working directory to this repository
setwd("/path/to/breast-cancer-age-clinicopathology")

# Run the data processing pipeline
source("breast_cancer_analysis.R")
```

The script prints a summary upon completion (total records processed, unique patients) and saves output to `results/`.

## Data Processing Pipeline

The script follows 10 sequential steps:

1. **Load packages** — Checks and installs required R packages
2. **Import data** — Reads the REDCap CSV export
3. **Handle bilateral cases** — Splits bilateral (side=3) into right (side=1) and left (side=2) records
4. **Consolidate pathology data** — Merges side-specific columns (e.g., `fnac_right`/`fnac_left` → `fnac`)
5. **Process treatment variables** — Converts checkbox fields to comma-separated regimen strings (e.g., "CAF,EC/P")
6. **Merge lymph node data** — Left-joins supplementary lymph node assessment data
7. **Create factor variables** — Converts numeric codes to labeled factors (e.g., 1→"Right", 2→"Left")
8. **Build final dataset** — Selects and orders columns for the analysis-ready output
9. **Add variable labels** — Assigns descriptive Hmisc labels for documentation
10. **Export results** — Writes processed CSV and variable label dictionary

### Treatment Regimen Abbreviations

| Abbreviation | Regimen |
|-------------|---------|
| CAF | Cyclophosphamide + Adriamycin + 5-Fluorouracil |
| CEF | Cyclophosphamide + Epirubicin + 5-Fluorouracil |
| CMF | Cyclophosphamide + Methotrexate + 5-Fluorouracil |
| EC | Epirubicin + Cyclophosphamide |
| AC | Adriamycin + Cyclophosphamide |
| EC/P | EC + Paclitaxel |
| EC/D | EC + Docetaxel |
| GC | Gemcitabine + Carboplatin |
| DC | Docetaxel + Cyclophosphamide |

### Molecular Subtypes

| Subtype | IHC Profile |
|---------|------------|
| Luminal A | ER+ and/or PR+, HER2− |
| Luminal B | ER+ and/or PR+, HER2+ |
| HER2-enriched | ER−, PR−, HER2+ |
| Basal-like (Triple Negative) | ER−, PR−, HER2− |

## Analysis Workflow

The complete analysis workflow for this study was:

```
REDCap Database
     │
     ▼
┌─────────────────────────────┐
│  breast_cancer_analysis.R   │  ◀── This repository
│  (Data cleaning & export)   │
└─────────────────────────────┘
     │
     ▼
processed_breast_cancer_data.csv
     │
     ▼
┌─────────────────────────────┐
│  SPSS / Excel               │  ◀── Not in this repository
│  (Statistical analysis)     │
│  - Chi-square tests         │
│  - Fisher's exact tests     │
│  - Descriptive statistics   │
│  - Cross-tabulations        │
└─────────────────────────────┘
     │
     ▼
Published Tables & Results
```

## Data Privacy

This repository contains de-identified clinical research data. Patient identifiers have been replaced with research numbers. Hospital numbers are retained for record linkage but do not contain personally identifiable information in this context.

### Missing Data Conventions

| Representation | Meaning |
|---------------|---------|
| `NA` / empty | True missing data |
| `-1` / "Unknown" | Unknown status |
| `0` / "No" or `99` / "Not performed" | Test not done or not applicable |

## License

This code is provided for research and educational purposes. Please cite the original publication when using this code or data.

## Contact

For questions about this study, please refer to the corresponding author listed in the [publication](https://doi.org/10.3332/ecancer.2022.1484).
