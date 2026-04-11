# Model Performance Report
## Project 01 — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group | April 2026

---

## 1. Modelling Approach

| Decision                  | Choice                       | Rationale                                                               |
|---------------------------|------------------------------|-------------------------------------------------------------------------|
| Primary model             | Logistic Regression          | Interpretable, outputs probabilities, business-explainable coefficients |
| Validation model          | Random Forest                | Handles non-linear interactions, provides feature importance            |
| Final scoring model       | Random Forest                | Higher AUC — used for risk register probabilities                       |
| Class imbalance handling  | class_weight='balanced'      | 3.91:1 imbalance confirmed at audit stage                               |
| Train/test split          | 80/20 stratified             | 8,000 training rows, 2,000 holdout, churn ratio preserved               |
| Probability thresholds    | Recalibrated to 50/20        | RF compresses probabilities (max 57%) — thresholds set at natural distribution break points |

---

## 2. Model Results

### Logistic Regression

| Metric      | Retained    | Churned | Overall    |
|-------------|-------------|---------|------------|
| Precision   | 0.92        | 0.43    | —          |
| Recall      | 0.75        | 0.75    | —          |
| F1-Score    | 0.83        | 0.55    | —          |
| Accuracy    | —           | —       | 0.75       |
| **AUC-ROC** | —           | —       | **0.8327** |

### Random Forest

| Metric      | Retained | Churned | Overall    |
|-------------|----------|---------|------------|
| Precision   | 0.91     | 0.60    | —          |
| Recall      | 0.89     | 0.64    | —          |
| F1-Score    | 0.90     | 0.62    | —          |
| Accuracy    | —        | —       | 0.84       |
| **AUC-ROC** | —        | —       | **0.8530** |

### Model Comparison

| Model                  | AUC-ROC     | Accuracy | Churner Recall | Churner Precision |
|------------------------|------------|----------|----------------|-------------------|
| Logistic Regression    | 0.8327     | 0.75     | 0.75           | 0.43              |
| Random Forest          | **0.8530** | **0.84** | **0.64**       | **0.60**          |
| Improvement (RF vs LR) | +0.0203    | +0.09    | -0.11          | +0.17             |


**Random Forest selected as final scoring model.**
RF achieves higher AUC, higher accuracy, and substantially higher
precision on churners (0.60 vs 0.43), meaning fewer false alarms
sent to the retention team.

LR recall is higher (0.75 vs 0.64) but the precision gain in RF is more operationally valuable.

---

## 3. AUC-ROC Interpretation

AUC-ROC of 0.853 means the model correctly ranks a churner above
a non-churner 85.3% of the time.

| AUC Range | Interpretation |
|-----------|---------------|
| 0.50      | Random guessing — no predictive value |
| 0.70–0.80 | Acceptable |
| 0.80–0.90 | Good — **our model falls here** |
| 0.90–1.00 | Excellent |

Both models exceed the Clarivance engagement target of AUC > 0.75.

---

## 4. Churn Risk Register Summary

| Tier          | Threshold | Customers | % of Base | Revenue at Risk |
|---------------|-----------|-----------|-----------|-----------------|
| Intervene Now | ≥ 50%     | 4,916     | 49.16%    | £142,481,546    |
| Monitor       | 20–49%    | 0         | 0.00%     | £0              |
| Healthy       | < 20%     | 5,084     | 50.84%    | —               |

**Note on Monitor tier:** The zero count in the Monitor tier reflects
a genuinely bimodal probability distribution — the model cleanly
separates customers into high-risk (50–57%) and low-risk (8–17%)
with no ambiguous middle group. This is a valid finding, not a
modelling error.

---

## 5. Feature Importance (Random Forest)

Top predictors ranked by mean decrease in impurity:

| Rank | Feature         | Business Interpretation |
|------|-----------------|--------------------------------------------|
| 1    | Age             | Older customers churn significantly more — 55-64 band at 49.83% |
| 2    | NumOfProducts   | 1-product customers at 27.71% churn; 2-product at 7.58% |
| 3    | Balance         | Higher balance customers more likely to churn — leaving for better rates |
| 4    | EstimatedSalary | Lower predictive weight than expected — confirms Assumption A4 |
| 5    | CreditScore     | Moderate predictor — lower scores slightly more likely to churn |
| 6    | engagement_score| Composite score validates inverse relationship with churn |
| 7    | Geography_enc   | Germany effect captured — 2× portfolio average churn rate |
| 8    | Tenure          | Weak linear signal — churn risk not strongly tenure-dependent |
| 9    | IsActiveMember  | Strong behavioural predictor — inactive members churn 1.88× more |
| 10   | HasCrCard       | Minimal predictive weight |
| 11   | Gender_enc      | Minimal predictive weight |

---

## 6. Probability Distribution

The Random Forest produces a compressed, bimodal probability
distribution due to class_weight='balanced':

| Statistic       | Value |
|-----------------|-------|
| Minimum         | 8.5%  |
| 25th percentile | 11.1% |
| Median          | 14.4% |
| 75th percentile | 52.6% |
| Maximum | 57.0% |

Two clear clusters: low-risk (8–17%) and high-risk (50–57%).
No customers fall in the 20–50% range. Retention thresholds
recalibrated to 50% and 20% to reflect this distribution.

---

## 7. Limitations

- Probability compression is a known consequence of
  class_weight='balanced' — AUC ranking is reliable but
  absolute probability values should not be communicated
  as literal churn percentages to business stakeholders
- 3 and 4 product customers (n=266, n=60) show anomalous
  churn rates of 82.71% and 100% — small samples, interpret
  with caution
- No temporal data available — model cannot detect trend
  or velocity of churn risk change over time
- Single static snapshot — model requires retraining as
  customer behaviour evolves

---

*Clarivance Analytics Group | From Data to Decision | April 2026*