# Download Instructions — Raw Dataset
## Project 01 | Retail Banking Customer Churn Analysis
## Clarivance Analytics Group

---

## Dataset Details

| Attribute     | Detail                                              |
|---------------|-----------------------------------------------------|
| Dataset Name  | Bank Customer Churn Prediction                      |
| Source        | Kaggle                                              |
| URL           | https://www.kaggle.com/datasets/shantanudhakadd/bank-customer-churn-prediction |
| File Name     | Churn_Modelling.csv                                 |
| Rename To     | bank_churn_raw.csv                                  |
| Rows          | ~10,000                                             |
| Columns       | 14                                                  |
| Licence       | CC0 Public Domain — no restrictions                 |

---

## Steps to Download

1. Go to the Kaggle URL above
2. Sign in to Kaggle (free account required)
3. Click the **Download** button — you will receive a ZIP file
4. Extract the ZIP
5. Locate `Churn_Modelling.csv`
6. Rename it to `bank_churn_raw.csv`
7. Place it in this folder: `data/raw/bank_churn_raw.csv`

---

## Why the Raw File Is Not Committed

The raw CSV is excluded from version control via `.gitignore`.
Reasons:
- Kaggle datasets should be downloaded directly from source to ensure
  licence compliance and to always retrieve the most current version
- Large binary/CSV files bloat Git history unnecessarily

The cleaned output (`data/cleaned/bank_churn_clean.csv`) is committed
after the SQL cleaning stage — that file is the verified, documented
baseline for all downstream analysis.

---

*Clarivance Analytics Group | From Data to Decision*