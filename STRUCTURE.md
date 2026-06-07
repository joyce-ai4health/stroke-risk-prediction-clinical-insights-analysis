# 📁 Project Structure Guide

This document explains the purpose of every folder and file in this repository.
Read this before adding any new file so it lands in the right place.

---

## Repository Layout

```
stroke-risk-prediction-clinical-insights-analysis/
│
├── data/
│   ├── raw/
│   │   └── stroke_prediction_dataset.csv
│   └── processed/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   ├── 02_eda.ipynb
│   ├── 03_feature_engineering.ipynb
│   └── 04_predictive_model.ipynb
│
├── sql/
│   ├── 01_demographic_risk_analysis.sql
│   ├── 02_clinical_risk_factors.sql
│   ├── 03_lifestyle_analysis.sql
│   └── 04_stroke_occurrence_summary.sql
│
├── powerbi/
│
├── reports/
│
├── images/
│
├── docs/
│
├── README.md
├── STRUCTURE.md          ← you are here
├── requirements.txt
└── .gitignore
```

---

## Folder & File Reference

### `data/`
Holds all dataset files. Never commit sensitive or personally identifiable patient data.

| Subfolder | What goes here |
|---|---|
| `raw/` | The original, untouched dataset exactly as downloaded from Kaggle. **Never edit files here.** The stroke dataset is a single CSV with demographic, lifestyle, and clinical columns including the stroke outcome label. |
| `processed/` | All outputs from the notebooks: the cleaned dataset (`stroke_cleaned.csv`), the model-ready dataset (`stroke_model_ready.csv`), and the saved trained model (`stroke_risk_model.pkl`). |

---

### `notebooks/`
All Jupyter notebooks for Python-based analysis. **Run them in number order** — each
one builds on the output of the previous one.

| File | Purpose |
|---|---|
| `01_data_cleaning.ipynb` | Load the raw CSV, inspect the dataset, handle the known missing values in the `bmi` column, validate data types, and save the cleaned file to `data/processed/`. Run this **first**. |
| `02_eda.ipynb` | Exploratory Data Analysis — demographic breakdowns, stroke rate by age group, hypertension and heart disease analysis, glucose and BMI distributions, lifestyle factor comparisons. Each chart must include a written interpretation. |
| `03_feature_engineering.ipynb` | Prepare the dataset for modelling — encode categorical columns, create age bands and glucose risk tiers, address class imbalance using SMOTE, and save the model-ready dataset to `data/processed/`. |
| `04_predictive_model.ipynb` | Train and evaluate classification models to predict stroke risk. Compare at least two algorithms, report performance metrics, plot feature importance, and export the final model. |

> **Tip:** Keep markdown cells in every notebook explaining what you are doing and why.
> A notebook that tells a story is far more impressive in a portfolio than one that
> is just blocks of code.

---

### `sql/`
SQL query files organized by analysis theme. Each file must have a comment block at
the top stating its purpose, and a comment above each query stating the business
question it answers.

| File | Covers |
|---|---|
| `01_demographic_risk_analysis.sql` | Stroke rate by age group, gender, marital status, residence type, and work type |
| `02_clinical_risk_factors.sql` | Stroke rate among patients with hypertension, heart disease, and combinations of both; average glucose and BMI by stroke outcome |
| `03_lifestyle_analysis.sql` | Stroke occurrence by smoking status; stroke rate across BMI categories (underweight, normal, overweight, obese) |
| `04_stroke_occurrence_summary.sql` | Overall stroke prevalence, high-risk patient profiles, summary statistics for the final report |

---

### `powerbi/`
Power BI dashboard files (`.pbix`). Three dashboards, each targeting a different
lens on the data.

| File (planned) | Covers |
|---|---|
| `01_stroke_risk_overview.pbix` | Overall stroke prevalence, demographic breakdown, key risk factor KPI cards |
| `02_patient_profile_analysis.pbix` | Patient segments by age, BMI, glucose level, and lifestyle — who is most at risk? |
| `03_clinical_insights.pbix` | Hypertension and heart disease impact, glucose and BMI risk tiers, preventive care opportunity areas |

> **Note:** `.pbix` files cannot be previewed on GitHub. Always export a PDF snapshot
> of each finished dashboard and save it to `reports/` so reviewers can see the
> work without opening Power BI.

---

### `reports/`
Written outputs and exported visuals — anything that summarises or presents findings.

| File (planned) | Description |
|---|---|
| `final_report.md` | Full project write-up: background, methodology, EDA findings, model results, and preventive healthcare recommendations |
| `executive_summary.md` | One-page plain-English summary for a clinical or non-technical audience — focus on actionable risk insights |
| `dashboard_01_snapshot.pdf` | PDF export of the Stroke Risk Overview dashboard |
| `dashboard_02_snapshot.pdf` | PDF export of the Patient Profile Analysis dashboard |
| `dashboard_03_snapshot.pdf` | PDF export of the Clinical Insights dashboard |

---

### `images/`
Screenshots and charts used inside `README.md` or project documentation.

| What goes here |
|---|
| Dashboard screenshots embedded in the README |
| Key EDA charts worth highlighting (e.g. stroke rate by age group, glucose distribution) |
| Model output visuals (confusion matrix, ROC curve, feature importance chart) |

> **Naming tip:** Use descriptive names like `eda_stroke_rate_by_age.png` or
> `model_roc_curve.png` rather than `image1.png`.

---

### `docs/`
Supporting documents that provide context for the project.

| File (planned) | Description |
|---|---|
| `linkedin_post_draft.md` | Draft of the LinkedIn portfolio post for this project |
| `data_dictionary.md` | Definitions for all 11 columns in the dataset including valid values for categorical fields (e.g. smoking status categories, work type options) |

---

### Root-level Files

| File | Purpose |
|---|---|
| `README.md` | Main project page visible on GitHub. Should include project overview, tools used, key findings, model performance summary, and links to notebooks and dashboards. Update this last. |
| `STRUCTURE.md` | This file. Explains the repo layout so any collaborator or reviewer understands where things live. |
| `requirements.txt` | Lists all Python packages needed to run the notebooks. Run `pip install -r requirements.txt` to install them. Includes `imbalanced-learn` for SMOTE to handle class imbalance. |
| `.gitignore` | Tells Git which files to ignore (checkpoint files, system files, etc.). Do not delete this. |
| `.gitkeep` | Empty placeholder files used to track empty folders in Git. Delete them once real files are added to that folder. |

---

## Rules to Follow

1. **Never edit files in `data/raw/`** — treat the original dataset as read-only at all times.
2. **Run notebooks in order** — `01` → `02` → `03` → `04`. Each depends on the output of the one before it.
3. **Handle class imbalance explicitly** — stroke datasets are heavily skewed (very few positive stroke cases). Address this in `03_feature_engineering.ipynb` using SMOTE from `imbalanced-learn` and document the decision.
4. **Comment your SQL** — every query needs a comment explaining the business question it answers.
5. **Report more than accuracy** — for imbalanced medical data, accuracy alone is misleading. Always report precision, recall, and F1-score in the modelling notebook.
6. **Save the model** — export the final trained model using `joblib` to `data/processed/stroke_risk_model.pkl`.
7. **Export dashboard PDFs** — always save a PDF snapshot of Power BI dashboards to `reports/` before closing.
8. **Update the README last** — add screenshots, model performance metrics, and key findings once the project is complete.
9. **Delete `.gitkeep` files** once real files have been added to that folder.