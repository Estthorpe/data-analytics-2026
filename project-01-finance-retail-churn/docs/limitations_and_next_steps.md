# Limitations & Next Steps
## Project 01 — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group | April 2026

---

## Data Limitations

- **No transaction date field:** The dataset contains no calendar
  timestamps. Cohort analysis was performed on the Tenure variable as
  a time-in-relationship proxy — this approximates but does not replace
  true calendar-period cohort analysis. Seasonal churn patterns cannot
  be detected.

- **EstimatedSalary is unverified:** The salary field is described as
  estimated and is not validated against any external source. It showed
  near-zero correlation with churn (0.01) and minimal feature importance.
  Results should be interpreted with low confidence for salary-based
  segmentation.

- **Static snapshot:** The dataset represents a single point-in-time
  extract. It cannot detect the velocity of customer disengagement —
  a customer declining from active to inactive to churned is not visible
  in a static record.

- **Geography is country-level only:** No sub-national segmentation
  is available. Germany's 32.44% churn rate may mask significant
  regional variation within Germany that cannot be diagnosed with
  this data.

- **Three trailing CSV columns:** DuckDB's DESCRIBE function detected
  three unnamed columns (column14, column15, column16) not visible in
  Excel. These were identified as CSV encoding artefacts and excluded.
  Their origin in the source data is undocumented.

---

## Model Limitations

- **Probability compression:** Random Forest with
  class_weight='balanced' compresses predicted probabilities — the
  maximum predicted churn probability is 57%, not 100%. AUC-ROC
  ranking is reliable but absolute probability values should not be
  communicated to business stakeholders as literal churn percentages.
  Retention tier thresholds were recalibrated to 50/20 to account for
  this compression.

- **3 and 4 product anomaly:** Customers with 3 products churn at
  82.71% and customers with 4 products at 100%. These rates are based
  on small samples (n=266 and n=60 respectively) and should be
  interpreted with caution. The pattern likely reflects over-selling
  behaviour rather than a generalised rule about high product counts.

- **Class imbalance:** The 3.91:1 retained-to-churned ratio was
  handled via class_weight='balanced' but not via resampling. SMOTE
  was evaluated and deferred — the current approach produces acceptable
  AUC scores without the risk of synthetic sample artefacts.

- **No temporal validation:** The model was evaluated on a random
  holdout set, not a time-based holdout. In a production deployment,
  the model should be validated on future churners — customers who
  left after the model training cutoff — to confirm predictive
  performance is not inflated by data leakage.

---

## Assumptions Made

- **A1 — Zero-balance records retained:** Customers with £0 account
  balance were retained in the dataset and assigned to the Zero Balance
  tier rather than removed as invalid records. The audit confirmed these
  customers churn at 13.82% — the lowest rate of any tier — supporting
  their retention as valid, dormant account holders.

- **A2 — CreditScore range 300–850:** Industry standard range applied.
  The audit confirmed no records outside this range — the filter was
  retained as a defensive safeguard only.

- **A3 — Age range 18–100:** Reasonable customer age range applied.
  The audit confirmed no records outside this range — the filter was
  retained as a defensive safeguard only.

- **A4 — EstimatedSalary retained:** Despite low predictive confidence,
  EstimatedSalary was retained in the feature set. Tree-based models
  handle low-importance features gracefully. Its feature importance
  ranking confirmed it contributes minimally to predictions.

- **A5 — Revenue at risk proxy:** The revenue_at_risk column uses
  account Balance × churn_probability as a proxy. This understates
  true revenue risk as it excludes product margin, fee income, and
  relationship value. The figure should be treated as a conservative
  floor estimate.

---

## What Would Improve This Analysis

- **Transaction-level data with timestamps** would enable true cohort
  analysis, detection of disengagement velocity, and seasonal churn
  pattern identification.

- **Customer service interaction history** — complaint frequency, call
  centre contacts, NPS scores — would add strong leading indicators
  of churn intent not captured in account data.

- **Competitor rate and product data** would allow correlation of
  Germany's elevated churn with specific competitor campaigns or rate
  changes — enabling proactive rather than reactive intervention.

- **Product profitability data** would replace the balance proxy in
  revenue at risk calculations with actual margin-based figures,
  improving the precision of ROI estimates.

- **12+ months of longitudinal data** with monthly model retraining
  would capture seasonality, measure the effectiveness of prior
  retention interventions, and allow survival analysis modelling.

- **SHAP values** (SHapley Additive exPlanations) would provide
  customer-level explainability — telling a relationship manager
  exactly why a specific customer is at risk, enabling more targeted
  outreach conversations.

---

*Clarivance Analytics Group | From Data to Decision | April 2026*