/* SQL FILE 3: 03_lifestyle_analysis.sql
Analysis 1: Stroke Rate by Smoking Status

=====================================================
BUSINESS QUESTION
=====================================================
How does stroke prevalence vary across smoking categories?

WHY THIS ANALYSIS MATTERS
Smoking is a major modifiable risk factor for stroke.
=====================================================
*/

SELECT
    smoking_status,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY smoking_status

ORDER BY stroke_rate_pct DESC;


/* INTERPRETATION

Former smokers exhibited the highest stroke prevalence among all
smoking-status categories, followed by current smokers and never
smokers. This finding suggests that smoking history may be associated
with increased stroke occurrence within the dataset.

Interestingly, former smokers experienced a higher stroke rate than
current smokers. While this pattern may reflect differences in age,
underlying health conditions, or other cardiovascular risk factors,
the current analysis cannot determine the cause of this relationship.

Current smokers showed a slightly higher stroke prevalence than never
smokers, although the difference was relatively modest. This suggests
that smoking status may provide useful predictive information but is
unlikely to fully explain stroke risk on its own.

The "Unknown" smoking-status category recorded the lowest stroke rate.
However, because this category represents patients with missing or
unclassified smoking information, its interpretation should be treated
with caution.

Overall, the findings indicate an association between smoking history
and stroke occurrence, but additional multivariate analysis would be
required to determine the independent contribution of smoking after
accounting for factors such as age, hypertension, heart disease,
glucose levels, and BMI.

*/






/*
Analysis 2: Stroke Rate by BMI Category

=====================================================
BUSINESS QUESTION
=====================================================
Does stroke prevalence vary across BMI categories?

WHY THIS ANALYSIS MATTERS
Body weight is strongly associated with cardiovascular risk.
=====================================================
*/

SELECT
    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY bmi_category

ORDER BY stroke_rate_pct DESC;



/* INTERPRETATION

Stroke prevalence varied across BMI categories, indicating an
association between body weight status and stroke occurrence.

Overweight patients exhibited the highest stroke prevalence (7.14%),
followed by obese patients (5.10%), while normal-weight patients
recorded a substantially lower stroke prevalence (2.82%). This pattern
suggests that the relationship between BMI and stroke risk may not be
strictly linear within this dataset.

Underweight patients recorded the lowest stroke prevalence (0.30%).
However, because only one stroke case was observed in this group, the
result should be interpreted cautiously as small sample sizes can
produce unstable rate estimates.

The higher stroke prevalence observed among overweight and obese
patients compared with normal-weight patients suggests that elevated
BMI may be associated with increased stroke occurrence. However,
additional analysis would be required to determine whether BMI
independently contributes to stroke risk after accounting for factors
such as age, hypertension, heart disease, glucose levels, and smoking
status.

Overall, BMI appears to provide useful predictive information, although
its relationship with stroke risk is more complex than a simple
increase across categories.

*/




/*
Analysis 3: Combined Lifestyle Risk

=====================================================
BUSINESS QUESTION
=====================================================
How does stroke prevalence compare between
high-risk and low-risk lifestyle groups?

WHY THIS ANALYSIS MATTERS
Combining risk factors often reveals stronger
associations than examining them individually.
=====================================================
*/

SELECT
    CASE
        WHEN smoking_status IN ('smokes','formerly smoked')
             AND bmi >= 30
             THEN 'Smoker + Obese'

        WHEN smoking_status = 'never smoked'
             AND bmi BETWEEN 18.5 AND 25
             THEN 'Non-Smoker + Normal BMI'

        ELSE 'Other'
    END AS lifestyle_group,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY lifestyle_group

ORDER BY stroke_rate_pct DESC;


/* INTERPRETATION

Stroke prevalence differed across the combined lifestyle groups.
Patients classified as both smokers and obese exhibited the highest
stroke prevalence (6.56%), compared with 3.56% among non-smokers with
normal BMI and 4.70% within the mixed "Other" category.

The stroke prevalence observed in the smoker-and-obese group was
approximately 84% higher than that of the non-smoker and normal-BMI
group, suggesting that the coexistence of multiple lifestyle-related
risk factors may be associated with increased stroke occurrence.

The "Other" category accounted for the majority of patients and
contained a heterogeneous mix of smoking and BMI profiles. As a
result, interpretation of this group is limited because substantial
variation may exist within the category.

Importantly, the non-smoker and normal-BMI group still experienced
a measurable stroke prevalence (3.56%), indicating that factors
beyond smoking status and BMI likely contribute to stroke risk.

Overall, the findings suggest that combined lifestyle characteristics
may provide useful predictive information, although additional analysis
would be required to determine the independent and interactive effects
of smoking status and BMI on stroke risk.

*/