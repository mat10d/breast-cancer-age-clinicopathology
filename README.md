# Breast Cancer in Elderly Patients: Clinicopathological Analysis

## Citation

**Ogunbiyi OJ, Shittu OB, Fatiregun AA, Wuraola FO, Habeebu MY, Ayandipo OO (2021)**
Breast cancer in elderly patients: a clinicopathological review of a Nigerian database
*ecancermedicalscience* 15:1484
DOI: [10.3332/ecancer.2021.1484](https://doi.org/10.3332/ecancer.2021.1484)
URL: https://ecancer.org/en/journal/article/1484-breast-cancer-in-elderly-patients-a-clinicopathological-review-of-a-nigerian-database

## Principal Investigator

**Funmi Wuraola, MD**

## Project Description

This repository contains the data processing and analysis code for a clinicopathological study of breast cancer cases from a Nigerian hospital database. The study examines pathological characteristics, immunohistochemistry profiles, treatment patterns, and clinical outcomes in breast cancer patients.

### Key Features

- **Data source**: REDCap database from Nigerian tertiary hospital
- **Analysis focus**:
  - Clinicopathological characteristics
  - Diagnostic workup (FNAC, tru-cut, biopsies)
  - Histopathology and grading (Nottingham system)
  - TNM staging
  - Immunohistochemistry (ER, PR, HER2)
  - Molecular subtypes
  - Treatment modalities (surgery, chemotherapy, hormone therapy, radiotherapy)
  - Follow-up and survival outcomes

### Data Processing Features

The analysis pipeline handles:

1. **Bilateral cases**: Splits bilateral breast cancer cases into separate laterality-specific records
2. **Laterality consolidation**: Merges side-specific pathology data into unified fields
3. **Multi-select variables**: Converts checkbox treatment regimens to comma-separated values
4. **Data merging**: Integrates supplementary lymph node data
5. **Factor coding**: Transforms numeric codes to labeled categorical variables
6. **Variable labeling**: Adds descriptive metadata using Hmisc labels

## Repository Structure

```
git_repo/
├── README.md                                   # This file
├── breast_cancer_analysis.R                    # Main analysis script
├── 18114DevelopingABrea-Post2018PathologyStu_DATA_2022-01-12_0517.csv  # Input data
├── Lymph.csv                                   # Lymph node supplementary data
├── results/                                    # Output directory
│   ├── processed_breast_cancer_data.csv        # Processed dataset (generated)
│   └── variable_labels.csv                     # Variable label dictionary (generated)
└── .gitignore                                  # Git ignore rules
```

## Requirements

### R Version

This analysis was developed using R version 4.x or higher.

### Required R Packages

The following R packages are required:

- **Hmisc** (≥4.5.0): Variable labeling and data management
- **dplyr** (≥1.0.0): Data manipulation
- **lubridate** (≥1.7.0): Date/time handling
- **tibble** (≥3.0.0): Modern data frames
- **tidyr** (≥1.1.0): Data reshaping and tidying

### Installing Dependencies

The script will automatically install missing packages. Alternatively, you can install them manually:

```r
install.packages(c("Hmisc", "dplyr", "lubridate", "tibble", "tidyr"))
```

## Usage

### Running the Analysis

1. Ensure all required packages are installed
2. Set your working directory to the `git_repo/` folder
3. Run the analysis script:

```r
source("breast_cancer_analysis.R")
```

### Expected Outputs

The script generates two CSV files in the `results/` directory:

1. **processed_breast_cancer_data.csv**: Complete processed dataset with:
   - Consolidated laterality-specific pathology data
   - Labeled factor variables
   - Merged lymph node information
   - Treatment regimens as comma-separated strings

2. **variable_labels.csv**: Data dictionary mapping variable names to descriptive labels

### Console Output

The script prints summary statistics upon completion:
- Total records processed
- Number of unique patients
- Output file locations

## Data Notes

### Input Data Files

- `18114DevelopingABrea-Post2018PathologyStu_DATA_2022-01-12_0517.csv`: Main pathology dataset exported from REDCap (last updated: 2022-01-12)
- `Lymph.csv`: Supplementary lymph node assessment data

### Data Privacy

This repository contains de-identified clinical research data. Patient identifiers have been replaced with research numbers. Hospital numbers are retained for record linkage but do not contain personally identifiable information in this context.

### Missing Data

Missing values are represented as `NA` in R and as empty strings in CSV exports. The code distinguishes between:
- True missing data (`NA`)
- "Unknown" status (coded as -1 or 99)
- "Not performed" tests (coded as 0 or specific values)

## Methodology Notes

### Bilateral Case Handling

Patients with bilateral breast cancer (side = 3) are split into two records:
- One record for the right side (side = 1)
- One record for the left side (side = 2)

This allows laterality-specific pathology and treatment data to be properly analyzed while maintaining the patient-tumor relationship.

### Treatment Regimen Coding

Chemotherapy and hormone therapy regimens use standard abbreviations:
- **CAF**: Cyclophosphamide + Adriamycin + 5-Fluorouracil
- **CEF**: Cyclophosphamide + Epirubicin + 5-Fluorouracil
- **CMF**: Cyclophosphamide + Methotrexate + 5-Fluorouracil
- **EC**: Epirubicin + Cyclophosphamide
- **AC**: Adriamycin + Cyclophosphamide
- **EC/P**: EC + Paclitaxel
- **EC/D**: EC + Docetaxel
- **GC**: Gemcitabine + Carboplatin
- **DC**: Docetaxel + Cyclophosphamide

### Molecular Subtypes

Classified based on immunohistochemistry:
1. **Luminal A**: ER+ and/or PR+, HER2-
2. **Luminal B**: ER+ and/or PR+, HER2+
3. **HER2-enriched**: ER-, PR-, HER2+
4. **Basal-like**: ER-, PR-, HER2- (Triple negative)

## Reproducibility

This repository is designed for full reproducibility:
- All analysis code is version-controlled
- Package dependencies are explicitly documented
- Data processing steps are clearly annotated
- Intermediate results can be regenerated from source data

## License

This code is provided for research and educational purposes. Please cite the original publication when using this code or data.

## Contact

For questions about this analysis, please refer to the corresponding author listed in the publication.

## Acknowledgments

Data were collected as part of a multi-institutional study of breast cancer pathology in Nigeria. We acknowledge the contributions of pathologists, clinicians, and data managers at participating institutions.
