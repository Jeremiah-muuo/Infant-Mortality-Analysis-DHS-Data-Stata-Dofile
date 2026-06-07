# Infant Mortality Analysis Using DHS Data – Stata Do‑file

[![Stata](https://img.shields.io/badge/Stata-15+-blue)](https://www.stata.com/)
[![DHS](https://img.shields.io/badge/data-DHS-orange)](https://dhsprogram.com/)

## 📌 Overview

Stata do‑file for analysing infant mortality using **Demographic and Health Survey (DHS)** data. Defines the infant mortality outcome (death before 12 months), applies DHS survey weights, restricts to births in the last 5 years, categorises 10+ socio‑economic and demographic variables, runs chi‑square cross‑tabulations, encodes categories, and fits a logistic regression model to identify predictors of infant mortality. A clean, reproducible workflow for DHS‑style survival analysis.

---

## 🎯 Objectives

- ✅ Define infant mortality (`b5 == 0` & `b7 < 12`)  
- ✅ Apply DHS survey weights (`v005 / 1,000,000`) using `svyset`  
- ✅ Restrict analysis to births in the last 5 years  
- ✅ Recode categorical variables (water source, toilet type, family size, religion, occupation, marital status, etc.)  
- ✅ Generate derived variables (age groups, time to water source, etc.)  
- ✅ Run descriptive cross‑tabs with chi‑square tests  
- ✅ Encode string categories to numeric variables  
- ✅ Fit logistic regression (`logit`) to identify risk factors  
- ✅ Export cleaned dataset (optional)

---

## 📁 Repository Structure
Infant-Mortality-Stata/
├── Dofile_1.do # Main Stata do‑file
├── README.md # This file
└── data/ (optional) # Raw and cleaned datasets

---

## 🔧 Requirements

- **Stata** (version 15 or later)  
- **DHS dataset** (e.g., KDHS 2022) with standard DHS variable names:
  - `v005` (sample weight)
  - `v021` (primary sampling unit)
  - `v023` (stratum)
  - `b5` (child survival status)
  - `b7` (age at death in months)
  - `b2` (date of birth), `v007` (survey year), etc.

---

## 🚀 Usage

1. **Clone the repository**
   ```bash
   git clone https://github.com/Jeremiah-muuo/Infant-Mortality-Stata.git
   Open Stata and set the working directory to the repository folder.

Update the file path in Dofile_1.do to point to your DHS dataset (e.g., "path/to/your/dhs_data.dta").
do "Dofile_1.do"
or copy and paste the code into the Stata command window.

The cleaned dataset and logistic regression results will appear in the Stata output window.

📊 Key Variables Created
Original Variable	New Categorical Variable	Categories
v113	Source_of_drinking_water	Piped Water, Wells/Boreholes, Natural Sources, Containerised, Others
v115	Time_to_Water_Source	Short Time, Medium Time, Long Time, On Premises, Don't Know
v116	Type_of_Toilet_facility	Flush Toilet, Pit with Slab, Pit without Slab, No Toilet Facility, Other
v136	Family_Size	1‑5, 6‑10, More Than 10
v201	Children_Ever_Born	1‑3, 4‑7, More than 7
v212	Age_at_First_Birth	<20 Yrs, 20‑30 Yrs, >30 Yrs
v501	Marital_Status	Single, Married, Divorced, Widowed
v716	Occupation	Unemployed, Employed, Others
v130	Religion	Christian, Traditionists, Islam, Others, No religion
v013	Age_Group	15‑19, 20‑24, …, 45‑49
All categorical variables are then encoded to numeric (NUM*) for logistic regression.

📈 Output Example
Cross‑tabulation with chi‑square test:

stata
tab infant_mortality v013, row chi2
Logistic regression output:

stata
logit infant_mortality NUMSource_of_drinking_water NUMFamily_Size ... v013
Odds ratios, p‑values, and confidence intervals for each predictor.

🤝 Contributing
Issues and pull requests are welcome. For major changes, please open an issue first to discuss.

📬 Contact
Jeremiah Muuo
📧 jeremiahmuuo39@gmail.com
🔗 LinkedIn
🐙 GitHub

📄 License
This project is for academic and research purposes. Please cite appropriately if used in publications.

Last updated: June 2026

text

---

Copy and paste this into your `README.md` file. Let me know if you want any sections adjusted or removed!


