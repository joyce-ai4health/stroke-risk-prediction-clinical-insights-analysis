/*
SQL FILE 1 : 01_demographic_risk_analysis.sql
Analysis 1: Stroke Rate by Age Band

=====================================================
BUSINESS QUESTION
=====================================================
How does stroke prevalence vary across age groups?

WHY THIS ANALYSIS MATTERS
Age is one of the strongest known stroke risk factors.
This analysis helps identify which age groups are most vulnerable.
=====================================================
*/

SELECT
    CASE
        WHEN age < 40 THEN '< 40'
        WHEN age BETWEEN 40 AND 60 THEN '40-60'
        ELSE '60+'
    END AS age_band,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY age_band

ORDER BY age_band;


/* INTERPRETATION

Age emerged as one of the strongest predictors of stroke in this dataset.
Stroke prevalence increased from 0.37% among patients younger than
40 years to 13.57% among patients aged 60 years and above, with more
than 70% of all stroke cases occurring in the oldest age group.

These findings reinforce the importance of age-based risk stratification
and suggest that preventive interventions implemented during middle
age may help reduce stroke burden later in life.

*/



/*
Analysis 2: Stroke Rate by Gender

=====================================================
BUSINESS QUESTION
=====================================================
Does stroke prevalence differ by gender?

WHY THIS ANALYSIS MATTERS
Understanding gender-based differences may help identify
demographic groups requiring targeted prevention efforts.
=====================================================
*/

SELECT
    gender,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY gender;


/* INTERPRETATION

Male patients exhibited a slightly higher stroke prevalence (5.11%)
than female patients (4.71%), representing an approximately 8.5%
higher prevalence among males. Despite this, females accounted for
56.6% of all stroke cases due to their larger representation in the
dataset.

The small difference in stroke prevalence suggests that gender alone
may be a relatively weak predictor of stroke compared with stronger
clinical risk factors such as age, hypertension, heart disease, and
smoking status. The "Other" category contained only one observation
and should be handled carefully during statistical analysis and
predictive modelling.

*/



/*
Analysis 3: Stroke Rate by Work Type

=====================================================
BUSINESS QUESTION
=====================================================
Does stroke prevalence vary across work categories?

WHY THIS ANALYSIS MATTERS
Employment status may influence lifestyle, healthcare
access, stress levels, and overall health outcomes.
=====================================================
*/

SELECT
    work_type,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY work_type

ORDER BY stroke_rate_pct DESC;



/* INTERPRETATION

Stroke prevalence varied across work type categories, with self-employed
individuals exhibiting the highest stroke rate (7.94%), followed by
private-sector employees (5.09%) and government employees (5.02%).

Although private-sector workers accounted for the largest number of
stroke cases (149 cases; 59.8% of all strokes), this largely reflects
their greater representation within the dataset rather than a higher
individual risk.

Children exhibited a very low stroke prevalence (0.29%), which is
consistent with the generally lower occurrence of stroke in younger
populations. The "Never_worked" category contained only 22 patients and
recorded no stroke cases, making it insufficient for meaningful
statistical interpretation.

The elevated stroke prevalence observed among self-employed individuals
suggests that work type may provide useful predictive information.
However, work type is likely associated with other factors such as age
and underlying health conditions. Additional multivariate analysis would
be required to determine whether work type independently contributes to
stroke risk.

*/







/*
Analysis 4: Stroke Rate by Residence Type

=====================================================
BUSINESS QUESTION
=====================================================
Do urban and rural populations experience different stroke rates?

WHY THIS ANALYSIS MATTERS
Healthcare access and environmental factors may differ
between urban and rural communities.
=====================================================
*/

SELECT
    Residence_type,

    COUNT(*) AS total_patients,

    SUM(stroke) AS stroke_cases,

    ROUND(
        SUM(stroke) * 100.0 / COUNT(*),
        2
    ) AS stroke_rate_pct

FROM stroke_cleaned

GROUP BY Residence_type;


/* INTERPRETATION

Stroke prevalence was slightly higher among urban residents (5.20%)
than rural residents (4.53%), representing a difference of 0.67
percentage points and an approximately 14.8% higher prevalence in
the urban population.

Urban residents accounted for 54.2% of all stroke cases, while rural
residents accounted for 45.8%. Because the urban and rural populations
were nearly equal in size, this comparison is not substantially
influenced by differences in group representation.

The relatively small difference in stroke prevalence suggests that
residence type may provide some predictive information but is likely
a weaker predictor than major clinical risk factors such as age,
hypertension, heart disease, and smoking status.

Residence type may also be associated with other demographic,
socioeconomic, or lifestyle characteristics that are not captured
directly in this analysis. Additional multivariate analysis would be
required to determine whether residence type independently contributes
to stroke risk.

*/