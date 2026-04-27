# Methodology Documentation
## Project 01 — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group | April 2026

---

## Analytical Framework

This project follows the Clarivance Analytics Group 5-Tier Delivery
Framework, progressing from descriptive through to prescriptive
analysis. Each tier builds on the previous — no tier is skipped.

| Tier | Question Answered | Method |
|------|------------------|--------|
| 1 — Descriptive | What happened? | SQL aggregations, Power BI visualisations |
| 2 — Diagnostic | Why did it happen? | Segmentation, cross-tabulation, Pareto |
| 3 — Predictive | What will happen? | Logistic Regression + Random Forest |
| 4 — Prescriptive | What should we do? | Retention tiering, ROI simulation |
| 5 — Narrative | So what? | Executive summary, Decision Document |

---

## Stage 1 — Data Quality Audit (Script 01)

**Tool:** DuckDB SQL

All analysis began with a comprehensive data quality audit before
any cleaning or transformation was applied. The audit documented:

- Row count verification (expected: 10,000)
- Null rate per column (threshold: flag >5%)
- Duplicate CustomerID detection
- Target variable class distribution
- Categorical value validation (Geography, Gender)
- Numerical range scan (CreditScore, Age, Balance, Salary)
- Outlier flagging (CreditScore outside 300–850, Age outside 18–100)
- Zero balance analysis by churn status

**Key finding at audit stage:** Three unexpected trailing columns
(column14, column15, column16) were detected by DuckDB's DESCRIBE
function — not visible in Excel. These were identified as CSV encoding
artefacts and explicitly excluded in the cleaning script.

---

## Stage 2 — Cleaning & Feature Engineering (Script 02)

**Tool:** DuckDB SQL

Columns were selected explicitly by name — not SELECT * — to
exclude the three trailing artefact columns confirmed at audit.
RowNumber, CustomerId, and Surname were dropped: no analytical
value; Surname constitutes PII.

**Five derived features were engineered:**

| Feature | Source Column(s) | Logic | Purpose |
|---------|-----------------|-------|---------|
| `age_band` | Age | 6 bands: 18-24 through 65+ | Age cohort analysis |
| `balance_tier` | Balance | 5 tiers: Zero through Premium | Dormant vs value segmentation |
| `credit_band` | CreditScore | 5 bands: Poor through Excellent | Readable Power BI display |
| `engagement_score` | IsActiveMember, HasCrCard, NumOfProducts | IsActive + HasCard + LEAST(Products,2) | Composite engagement index 0–4 |
| `tenure_band` | Tenure | 4 bands: New through Long-term | Relationship lifecycle stage |

**Cleaning decisions:**
- No nulls found — WHERE clause retained as a defensive safeguard
- No outliers found — range bounds retained as safeguard
- Zero-balance records retained per Assumption A1 — flagged as
  distinct segment, not errors

---

## Stage 3 — Analytical Queries (Script 03)

**Tool:** DuckDB SQL

Ten diagnostic queries generating descriptive and diagnostic insights:

| Query | Purpose | Technique |
|-------|---------|-----------|
| A — Overall churn rate | Baseline metric | Aggregation |
| B — Churn by Geography | Geographic concentration | GROUP BY with revenue context |
| C — Churn by Age Band | Age risk profile | Ordered GROUP BY |
| D — Churn by Products | Product depth signal | GROUP BY with dual-axis |
| E — Active vs Inactive | Behavioural predictor | Binary GROUP BY |
| F — Churn by Balance Tier | Balance relationship | GROUP BY with totals |
| G — Churn by Engagement Score | Composite feature validation | GROUP BY |
| H — High-Risk Segments | Root cause intersection | Multi-column GROUP BY with HAVING |
| I — Pareto Analysis | Revenue concentration | WINDOW FUNCTION — pct of total |
| J — Segment Ranking | Churn rank by Geography × Age | RANK() WINDOW FUNCTION |

---

## Stage 4 — Exploratory Data Analysis (Python)

**Tool:** Python — Pandas, Matplotlib, Seaborn

Seven visualisations produced in the Clarivance brand palette
(NAVY #0D1F3C, TEAL #00B4A6, GOLD #F5A623, RED #E03E3E,
GREEN #2ECC8F):

1. Headline churn rate + avg balance comparison
2. Churn rate by Geography with portfolio average line
3. Churn rate by Age Band with colour-coded risk bands
4. Churn rate by Number of Products — dual axis with count overlay
5. Active vs Inactive member churn rate comparison
6. Engagement score vs churn rate — inverse relationship validation
7. Feature correlation heatmap — input to feature selection

**Portable path construction:** All file paths built using
`subprocess` + `git rev-parse --show-toplevel` to ensure
cross-machine GitHub compatibility without hardcoded absolute paths.

---

## Stage 5 — Predictive Modelling (Python)

**Tool:** Python — Scikit-learn

**Model 1: Logistic Regression**
- Purpose: Interpretable baseline, probability scoring
- Preprocessing: StandardScaler applied (mandatory for LR)
- Class imbalance: class_weight='balanced' (3.91:1 ratio)
- AUC-ROC: 0.8327

**Model 2: Random Forest**
- Purpose: Validation model and final scoring model
- Preprocessing: No scaling required
- Class imbalance: class_weight='balanced'
- Hyperparameters: n_estimators=200, max_depth=10
- AUC-ROC: 0.8530

**Model selection rationale:** Random Forest selected as the final
scoring model based on higher AUC-ROC (+0.0203) and substantially
higher precision on churners (0.60 vs 0.43 for LR). Higher precision
means fewer false alarms sent to the retention team — operationally
more valuable than LR's higher recall.

**Probability calibration:** RF with class_weight='balanced' produces
compressed probability scores (max 57%). Retention tier thresholds
recalibrated from standard 70/40 to 50/20 to reflect the actual
bimodal distribution. AUC-ROC ranking remains reliable.

**Train/test split:** 80/20 stratified (random_state=42).
Stratification ensures both splits preserve the 20.37% churn rate.

---

## Stage 6 — Power BI Dashboard

**Tool:** Power BI Desktop

Five pages built to the Clarivance dashboard standard:

| Page | Content | Primary Data Source |
|------|---------|-------------------|
| 1 — Executive Summary | 5 KPI cards, geography bar chart, narrative | ChurnClean |
| 2 — Descriptive Overview | Age, products, geography, balance tier charts | ChurnClean |
| 3 — Diagnostic Deep Dive | Matrix heatmap, active/inactive, credit, engagement | ChurnClean |
| 4 — Predictive Insights | Donut, age band probability, risk register table | RiskRegister |
| 5 — Prescriptive Tool | What-If sliders, ROI cards, guidance narrative | RiskRegister |

**DAX measures:** CALCULATE, DIVIDE, SWITCH(TRUE()), RANKX,
AVERAGE, FORMAT — all demonstrated across the 5 pages.

**What-If parameters:** Retention Rate % (0–100%, step 5%) and
Cost Per Customer £ (0–500, step 10%) — both functional and
connected to Revenue Protected, Programme Cost, Net ROI, and
ROI Ratio measures.

---

*Clarivance Analytics Group | From Data to Decision | April 2026*