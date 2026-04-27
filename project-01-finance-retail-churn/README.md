# Project 01 | Finance — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group

> **Client Brief:** A mid-size UK retail bank engaged Clarivance Analytics
> Group to investigate accelerating customer attrition, identify at-risk
> customers before they defect, and quantify the revenue at risk —
> enabling a targeted, ROI-positive retention strategy.

---

## Objective

Build a full-stack churn analytics solution — from raw data ingestion
through to a predictive risk model and executive-ready Power BI dashboard
— delivering all five analytical tiers: Descriptive → Diagnostic →
Predictive → Prescriptive → Narrative.

## Dataset

- **Source:** Bank Customer Churn Prediction — Kaggle
- **Size:** 10,000 rows | 14 columns
- **Link:** https://www.kaggle.com/datasets/shantanudhakadd/bank-customer-churn-prediction
- **Licence:** CC0 Public Domain — no restrictions on use or publication
- **Note:** Raw CSV excluded from version control per `.gitignore`.
  See `data/raw/download_instructions.md` for retrieval steps.

## Tools Used

`SQL (DuckDB)` `Python (Pandas, Scikit-learn, Matplotlib, Seaborn)`
`Power BI` `Excel` `Git / GitHub`

---

## Methodology

| Tier | Approach |
|------|----------|
| **Descriptive** | Churn rate breakdowns by geography, age band, product count, balance tier, tenure, and activity status |
| **Diagnostic** | Root cause segmentation — Geography × Age Band matrix, engagement score analysis, Pareto revenue concentration |
| **Predictive** | Logistic Regression (AUC 0.8327) + Random Forest (AUC 0.8530) — churn probability score per customer |
| **Prescriptive** | Retention tier segmentation (Intervene Now / Monitor / Healthy), revenue-at-risk calculation, What-If ROI simulator |
| **Narrative** | Executive summary, Decision Document, quantified business impact recommendations |

---

## Key Findings

- **Germany churns at 2× the portfolio average:** Germany produces a
  32.44% churn rate vs 16.15% for France and 16.67% for Spain. Despite
  representing 25% of the customer base, Germany accounts for 40% of
  all churned customers — with £97.9M in total balance at risk from
  German churn alone.

- **The 45–64 age band is the critical risk cohort:** Customers aged
  55–64 churn at 49.83% and 45–54 at 48.15% — nearly 2.5× the
  portfolio average. The highest-risk segment intersection — Germany +
  55–64 + inactive + single product — produces a 96% churn rate.

- **Product depth is the strongest actionable lever:** Single-product
  customers churn at 27.71%; two-product customers at 7.58% — a 3.7×
  difference. Moving a customer from one to two products is the
  highest-ROI retention action available.

- **4,916 customers are at Intervene Now risk:** Our dual-model
  framework (RF AUC 0.853) classifies 4,916 customers as Intervene Now,
  representing £142.5M in combined account value at risk.

- **Targeted intervention delivers 347:1 ROI:** Retaining 60% of
  Intervene Now customers at £50 per customer (£245,800 programme cost)
  is projected to protect £85.5M in account value.

---

## How to Reproduce

1. Download dataset from the Kaggle link above
2. Rename file to `bank_churn_raw.csv` and place in `data/raw/`
3. Download `duckdb.exe` from duckdb.org and place in the repo root
4. Open PowerShell, navigate to `project-01-finance-retail-churn/`
5. Launch DuckDB: `..\duckdb.exe`
6. Run scripts in order:
```sql
   .read sql/01_data_quality_checks.sql
   .read sql/02_cleaning_transformations.sql
   .read sql/03_analysis_queries.sql
```
7. Open `notebooks/churn_analysis.ipynb` in VS Code
8. Select the `Clarivance (venv)` kernel and run all cells
9. Open `dashboard/churn_dashboard.pbix` in Power BI Desktop
10. Connect to `data/cleaned/bank_churn_clean.csv` and
    `data/cleaned/churn_risk_register.csv` when prompted

---

## Repository Contents

| File / Folder | Description |
|---------------|-------------|
| `sql/01_data_quality_checks.sql` | Full data audit — row counts, nulls, duplicates, outliers, distributions |
| `sql/02_cleaning_transformations.sql` | Cleaning + 5 engineered features — age band, balance tier, credit band, engagement score, tenure band |
| `sql/03_analysis_queries.sql` | 10 diagnostic queries including WINDOW FUNCTION churn ranking and Pareto analysis |
| `notebooks/churn_analysis.ipynb` | Full EDA (7 visualisations) + LR + RF modelling + risk register export |
| `data/cleaned/bank_churn_clean.csv` | Verified clean dataset — 10,000 rows, 16 columns |
| `data/cleaned/churn_risk_register.csv` | Scored risk register — churn probability, retention tier, revenue at risk per customer |
| `dashboard/churn_dashboard.pbix` | Power BI — 5-page Clarivance dashboard with What-If ROI simulator |
| `dashboard/screenshots/` | PNG exports of all 5 dashboard pages |
| `outputs/executive_summary.md` | Full narrative analysis — 6 findings with quantified business impact |
| `outputs/model_performance_report.md` | AUC, Precision, Recall, F1 for both models |
| `outputs/insights_and_recommendations.md` | 5 prioritised recommendations with ROI calculations |
| `DECISION_DOCUMENT.md` | One-page C-suite brief — Problem / Approach / Findings / Recommendation / Impact |
| `docs/data_quality_audit.md` | Full cleaning log — nulls, duplicates, outliers, assumptions |
| `docs/methodology.md` | 5-tier analytical methodology documentation |
| `docs/limitations_and_next_steps.md` | Model constraints, data limitations, improvement roadmap |
| `data/data_dictionary.md` | Every column defined — source, type, modelling decision |

---

## Limitations

See [`docs/limitations_and_next_steps.md`](docs/limitations_and_next_steps.md)

---

*Clarivance Analytics Group | From Data to Decision*