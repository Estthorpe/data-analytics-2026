# Data Dictionary
## Project 01 | Retail Banking Customer Churn Analysis
## Clarivance Analytics Group

---

## Source File
`data/raw/bank_churn_raw.csv` — Bank Customer Churn Prediction (Kaggle, CC0)

---

## Original Columns (14)

| Column Name       | Data Type | Description                                           | Valid Range / Values         | Modelling Decision | Notes                                                                 |
|-------------------|-----------|-------------------------------------------------------|------------------------------|--------------------|-----------------------------------------------------------------------|
| `RowNumber`       | Integer   | Sequential row index — no analytical value            | 1 to 10,000                  | **DROP**           | Not a feature. Removed in SQL cleaning.                               |
| `CustomerId`      | Integer   | Unique customer identifier                            | Unique integers              | **DROP**           | Not a feature. Removed in SQL cleaning.                               |
| `Surname`         | Text      | Customer surname                                      | Free text                    | **DROP**           | PII. No predictive value. Removed in SQL cleaning.                    |
| `CreditScore`     | Integer   | Customer credit score                                 | 300 – 850                    | **KEEP**           | Key predictive feature. Outliers outside range removed at cleaning.   |
| `Geography`       | Text      | Country of the customer                               | France / Spain / Germany     | **KEEP — ENCODE**  | Label encoded for modelling. Inspect for misspellings at audit.       |
| `Gender`          | Text      | Customer gender                                       | Male / Female                | **KEEP — ENCODE**  | Label encoded for modelling. Binary — no ordinal assumption.          |
| `Age`             | Integer   | Customer age in years                                 | 18 – 100                     | **KEEP**           | Strong churn predictor. Age band engineered from this column.         |
| `Tenure`          | Integer   | Years the customer has held an account                | 0 – 10                       | **KEEP**           | Tenure band engineered from this column.                              |
| `Balance`         | Float     | Current account balance in local currency             | 0.00 and above               | **KEEP**           | Zero balance flagged as distinct segment. Balance tier engineered.    |
| `NumOfProducts`   | Integer   | Number of bank products the customer holds            | 1 – 4                        | **KEEP**           | Critical churn signal. 1-product customers expected to churn most.   |
| `HasCrCard`       | Binary    | Whether the customer holds a credit card              | 0 = No / 1 = Yes             | **KEEP**           | Component of engineered engagement score.                             |
| `IsActiveMember`  | Binary    | Whether the customer is an active member              | 0 = Inactive / 1 = Active    | **KEEP**           | Expected to be strongest single behavioural predictor of churn.       |
| `EstimatedSalary` | Float     | Customer's estimated annual salary                    | 0.00 and above               | **KEEP**           | Treat with low confidence — estimated, not verified. Flag in limits.  |
| `Exited`          | Binary    | Target variable — whether the customer churned        | 0 = Retained / 1 = Churned   | **TARGET**         | Class imbalance ~20/80. Must handle with class_weight='balanced'.     |

---

## Engineered Columns (added in SQL cleaning — `02_cleaning_transformations.sql`)

| Column Name       | Derived From  | Logic                                                                                   | Purpose                                      |
|-------------------|---------------|-----------------------------------------------------------------------------------------|----------------------------------------------|
| `age_band`        | `Age`         | <25 = '18-24' / 25-34 / 35-44 / 45-54 / 55-64 / 65+                                   | Cohort segmentation in Power BI              |
| `balance_tier`    | `Balance`     | 0 = 'Zero Balance' / <50k = 'Low' / 50k-100k = 'Mid' / 100k-150k = 'High' / >150k = 'Premium' | Segment dormant vs. value accounts      |
| `credit_band`     | `CreditScore` | <500 = 'Poor' / 500-599 = 'Fair' / 600-699 = 'Good' / 700-799 = 'Very Good' / 800+ = 'Excellent' | Readable banding for Power BI visuals   |
| `engagement_score`| `IsActiveMember`, `HasCrCard`, `NumOfProducts` | IsActiveMember + HasCrCard + LEAST(NumOfProducts, 2) | Composite engagement index (0–4)  |
| `tenure_band`     | `Tenure`      | 0-2 = 'New' / 3-5 = 'Developing' / 6-8 = 'Established' / 9-10 = 'Long-term'           | Tenure cohort grouping for analysis          |

---

## Risk Register Columns (added in Python modelling notebook)

| Column Name          | Derived From              | Logic                                                                 | Purpose                              |
|----------------------|---------------------------|-----------------------------------------------------------------------|--------------------------------------|
| `churn_probability`  | Random Forest model       | Predicted probability of churn (0–100%)                               | Primary risk score per customer      |
| `retention_tier`     | `churn_probability`       | ≥70% = 'Intervene Now' / 40-69% = 'Monitor' / <40% = 'Healthy'       | Retention action segmentation        |
| `revenue_at_risk`    | `Balance`, `churn_probability` | Balance × (churn_probability / 100)                              | Revenue exposure proxy per customer  |

---

*Clarivance Analytics Group | From Data to Decision*