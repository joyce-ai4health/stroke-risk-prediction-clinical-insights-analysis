Stroke Prediction Dataset Data Dictionary
# Data Dictionary

## Dataset Overview

This document describes all variables contained in the Stroke Prediction Dataset used for the Stroke Risk Prediction & Clinical Insights Analysis project.

---

## Variable Definitions

| Column Name | Data Type | Description | Valid Values / Range |
|------------|-----------|-------------|----------------------|
| gender | Categorical | Patient gender | Male, Female, Other |
| age | Numeric | Patient age in years | 0.08 – 82 |
| hypertension | Binary | Indicates whether the patient has hypertension | 0 = No, 1 = Yes |
| heart_disease | Binary | Indicates whether the patient has heart disease | 0 = No, 1 = Yes |
| ever_married | Categorical | Marital status | Yes, No |
| work_type | Categorical | Employment category | Private, Self-employed, Govt_job, children, Never_worked |
| Residence_type | Categorical | Area of residence | Urban, Rural |
| avg_glucose_level | Numeric | Average blood glucose level | 55.12 – 271.74 |
| bmi | Numeric | Body Mass Index | 10.3 – 97.6 |
| smoking_status | Categorical | Smoking history of patient | formerly smoked, never smoked, smokes, Unknown |
| stroke | Binary (Target Variable) | Indicates whether patient experienced stroke | 0 = No Stroke, 1 = Stroke |

---

## Target Variable

### stroke

The target variable used for predictive modelling.

| Value | Meaning |
|---------|---------|
| 0 | No Stroke |
| 1 | Stroke |

---

## Notes

### Missing Values

The BMI variable originally contained 201 missing values (3.93% of records).

Median imputation was applied during the data cleaning phase to preserve observations while minimizing the effect of extreme BMI values.

### Identifier Column

The original dataset contained an `id` column.

This variable was removed during data cleaning because it served only as a unique patient identifier and had no analytical or predictive value.

### Class Imbalance

The target variable is highly imbalanced:

| Class | Count | Percentage |
|---------|---------|---------|
| No Stroke | 4861 | 95.13% |
| Stroke | 249 | 4.87% |

This imbalance will be addressed during feature engineering and model development.
