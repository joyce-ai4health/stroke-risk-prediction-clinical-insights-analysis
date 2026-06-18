/* SQL FILE 2 : 02_clinical_risk_factors.sql



Analysis 1: Hypertension Only vs Heart Disease Only vs Both

=====================================================
BUSINESS QUESTION
=====================================================
Which cardiovascular condition is associated with
the highest stroke prevalence?

WHY THIS ANALYSIS MATTERS
Hypertension and heart disease are major clinical
risk factors for stroke.
=====================================================
*/

SELECT
    CASE
        WHEN hypertension = 1
             AND heart_disease = 0
             THEN 'Hypertension Only'

        WHEN hypertension = 0
             AND heart_disease = 1
             THEN 'Heart Disease Only'

        WHEN hypertension = 1
             AND heart_disease = 1
             THEN 'Both Conditions'

        ELSE 'Neither'
    END AS risk_group,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY risk_group

ORDER BY stroke_rate_pct DESC;


/* INTERPRETATION

Stroke prevalence varied substantially across cardiovascular risk
groups. Patients with both hypertension and heart disease exhibited
the highest stroke prevalence (20.31%), compared with 16.04% among
patients with heart disease only, 12.21% among patients with
hypertension only, and 3.39% among patients with neither condition.

Patients with both conditions experienced approximately six times the
stroke prevalence observed among patients with neither condition,
highlighting the strong association between cardiovascular disease
burden and stroke occurrence.

Although the "Both Conditions" group contained only 64 patients, it
recorded the highest observed stroke rate in the dataset. This finding
suggests that patients with multiple cardiovascular conditions may
represent a particularly high-risk population.

Interestingly, the "Neither" group accounted for the largest number
of stroke cases (149 cases; 59.8% of all strokes) despite having the
lowest stroke rate. This reflects the large size of the group and
indicates that factors beyond hypertension and heart disease may also
contribute to stroke risk.

These findings suggest that hypertension and heart disease are among
the strongest predictors of stroke in the dataset and may provide
substantial predictive value in machine learning models. Additional
analysis would be required to determine whether an interaction effect
exists between the two conditions.

*/







/*
Analysis 2: Average Glucose & BMI by Stroke Outcome


=====================================================
BUSINESS QUESTION
=====================================================
Do stroke patients exhibit different glucose and BMI levels?

WHY THIS ANALYSIS MATTERS
Glucose and BMI are important indicators of
metabolic and cardiovascular health.
=====================================================
*/

SELECT
    stroke,

    ROUND(AVG(avg_glucose_level),2) AS avg_glucose,

    ROUND(AVG(bmi),2) AS avg_bmi

FROM stroke_cleaned

GROUP BY stroke;



/* INTERPRETATION

Patients who experienced stroke had a higher average glucose level
(132.54) compared with patients who did not experience stroke
(104.80), representing an approximately 26.5% increase.

Stroke patients also exhibited a slightly higher average BMI
(30.09 versus 28.80), although the difference was relatively modest
compared with the glucose gap.

The larger separation in average glucose levels suggests that glucose
may be a more informative metabolic indicator of stroke occurrence
than BMI within this dataset. However, additional statistical analysis
would be required to determine the independent predictive contribution
of each variable.

Overall, the findings indicate a positive association between elevated
glucose levels and stroke occurrence, while BMI demonstrates a weaker
difference between the two groups.

*/









/*
Analysis 3: Patients with Glucose > 140

=====================================================
BUSINESS QUESTION
=====================================================
Among patients with elevated glucose levels,
what proportion experienced stroke?

WHY THIS ANALYSIS MATTERS
High blood glucose is associated with diabetes and
increased cardiovascular risk.
=====================================================
*/

SELECT
    COUNT(*) AS total_high_glucose,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

WHERE avg_glucose_level > 140;



/* INTERPRETATION

Among patients with high glucose levels (>125 mg/dL), 93 out of
821 patients experienced stroke, corresponding to a stroke prevalence
of 11.33%.

This prevalence is substantially higher than the overall dataset
stroke prevalence of approximately 4.87%, indicating a strong
association between elevated glucose levels and stroke occurrence.

The observed stroke rate among high-glucose patients is comparable
to that seen in patients with hypertension only (12.21%), suggesting
that elevated glucose may represent an important clinical risk
indicator within this dataset.

These findings are consistent with the broader observation that stroke
patients exhibited higher average glucose levels than non-stroke
patients. Further analysis would be required to determine the
independent predictive value of glucose after controlling for other
risk factors such as age, hypertension, heart disease, and BMI.

*/

