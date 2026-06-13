/* SQL FILE 4: 04_stroke_occurrence_summary.sql

Analysis 1: Overall Stroke Prevalence

=====================================================
BUSINESS QUESTION
=====================================================
What is the overall stroke prevalence in the dataset?

WHY THIS ANALYSIS MATTERS
Provides the baseline occurrence rate and highlights
class imbalance.
=====================================================
*/

SELECT
    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned;



/* INTERPRETATION

The overall dataset consists of 5,110 patients, with 249 recorded
stroke cases, giving a baseline stroke prevalence of 4.87%. This
serves as a reference point for interpreting all subgroup analyses.

Relative to this baseline, several groups demonstrate elevated stroke
prevalence. Formerly smoked patients (7.91%) show the highest observed
rate, approximately 1.62× the overall baseline. Overweight patients
(7.14%) also show elevated risk at approximately 1.47× the baseline.
The combined Smoker + Obese group (6.56%) similarly exceeds the
overall rate by 1.69 percentage points.

In contrast, individuals with normal BMI (2.82%) and those classified
as non-smokers with normal BMI (3.56%) show lower-than-average stroke
prevalence, suggesting potential protective association patterns within
the dataset.

The underweight group (0.30%) shows the lowest observed stroke rate,
however this estimate is based on a very small number of cases
(n=337, 1 stroke), making it statistically unstable and unsuitable for
strong inference.

Overall, the 4.87% baseline provides a useful anchor for comparison,
highlighting that several lifestyle- and health-related subgroups
deviate meaningfully from the population average. These differences
suggest that both metabolic (BMI-related) and behavioral (smoking-
related) factors may contribute to stroke risk, though multivariate
analysis would be required to quantify their independent effects.

*/







/*
Analysis 2: High-Risk Patient Profile

=====================================================
BUSINESS QUESTION
=====================================================
How many patients match a predefined high-risk profile?

HIGH-RISK PROFILE
- Age >= 60
- Hypertension = 1
- Heart Disease = 1
=====================================================
*/

SELECT
    COUNT(*) AS high_risk_patients

FROM stroke_cleaned

WHERE age >= 60
AND hypertension = 1
AND heart_disease = 1;



/* INTERPRETATION

A small high-risk subgroup of 55 patients (1.08% of the dataset) was
identified based on combined lifestyle risk criteria (e.g., smoker and
obese status).

This subgroup represents a small proportion of the overall population
but may carry elevated risk based on prior subgroup analysis.

Earlier findings showed that the smoker + obese group had a stroke
prevalence of 6.56%, compared with an overall dataset prevalence of
4.87%. This indicates that individuals with multiple coexisting
lifestyle risk factors may have higher observed stroke rates than the
general population.

If similar prevalence patterns apply within this high-risk subgroup,
the expected number of stroke cases would be small in absolute terms
but relatively higher in proportion to their population size. However,
this cannot be confirmed without direct outcome breakdown within this
specific subset.

Overall, this subgroup highlights the importance of combined lifestyle
risk profiling in stroke analysis and suggests value in further
investigation using multivariate or predictive modelling approaches.

*/












/*
Analysis 3: Top Factor Combinations Associated with Stroke

=====================================================
BUSINESS QUESTION
=====================================================
Which combinations of clinical factors appear most
frequently among stroke patients?

WHY THIS ANALYSIS MATTERS
Multiple risk factors often occur together and can
identify patient profiles requiring targeted intervention.
=====================================================
*/

SELECT
    hypertension,
    heart_disease,
    smoking_status,

    COUNT(*) AS stroke_cases

FROM stroke_cleaned

WHERE stroke = 1

GROUP BY
    hypertension,
    heart_disease,
    smoking_status

ORDER BY stroke_cases DESC

LIMIT 3;




/* INTERPRETATION

A total of 128 stroke cases (51.4% of all stroke cases) occurred in
patients without hypertension or heart disease.

Within this subgroup, smoking status varied as follows:
- Never smoked: 50 cases (39.1%)
- Formerly smoked: 43 cases (33.6%)
- Unknown: 35 cases (27.3%)

The presence of a substantial number of stroke cases in patients
without hypertension or heart disease indicates that additional
factors beyond these two major cardiovascular conditions contribute
to stroke occurrence in the dataset.

This includes established variables such as age, glucose levels, BMI,
and other potential risk factors not captured in this specific
stratification.

These findings suggest that stroke risk is multifactorial and that
reliance solely on hypertension and heart disease status may not fully
capture patient risk profiles. Further multivariate analysis would be
required to quantify the independent contribution of additional
predictors.

*/