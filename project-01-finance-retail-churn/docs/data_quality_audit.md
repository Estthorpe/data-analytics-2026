# Data Quality Audit Report
## Project 01 — Retail Banking Customer Churn Analysis
## Prepared by: Clarivance Analytics Group | April 2026

---

## 1. Row Count
| Measure         | Value                    |
|-----------------|--------------------------|
| Raw rows        | 10,000                   |
| Raw columns     | 14 expected / 17 detected|
| Expected rows   | 10,000                   |
| Match expected? | ✅ Yes — rows match      |

⚠️ DuckDB DESCRIBE detected 3 unnamed extra columns (column14, column15,
column16) not visible in Excel. These are trailing artefacts from CSV
encoding. Explicitly excluded in Script 02 cleaning.

---

## 2. Null Audit
| Column          | Null Count | Null % | Treatment              |
|-----------------|------------|--------|------------------------|
| CreditScore     | 0          | 0.00%  | No action required     |
| Geography       | 0          | 0.00%  | No action required     |
| Gender          | 0          | 0.00%  | No action required     |
| Age             | 0          | 0.00%  | No action required     |
| Tenure          | 0          | 0.00%  | No action required     |
| Balance         | 0          | 0.00%  | No action required     |
| NumOfProducts   | 0          | 0.00%  | No action required     |
| HasCrCard       | 0          | 0.00%  | No action required     |
| IsActiveMember  | 0          | 0.00%  | No action required     |
| EstimatedSalary | 0          | 0.00%  | No action required     |
| Exited          | 0          | 0.00%  | No action required     |

---

## 3. Duplicate Records
- Duplicate CustomerIds found: **0**
- Treatment: No action required — all CustomerIds are unique

---

## 4. Target Variable Distribution
| Exited       | Count | Pct %  |
|--------------|-------|--------|
| 0 (Retained) | 7,963 | 79.63% |
| 1 (Churned)  | 2,037 | 20.37% |

Class imbalance ratio: **3.91:1** — handled via `class_weight='balanced'`
in both Logistic Regression and Random Forest models.

---

## 5. Categorical Distributions

**Geography:**
| Value   | Count | Churn Rate | vs Portfolio Avg |
|---------|-------|------------|-----------------|
| France  | 5,014 | 16.15%     | -5.61 ppts      |
| Germany | 2,509 | 32.44%     | +10.68 ppts     |
| Spain   | 2,477 | 16.67%     | -5.09 ppts      |

⚠️ Germany churns at 1.49× the portfolio average — primary geographic
risk segment. Retention strategy must be Germany-weighted.

Unexpected values found: No

**Gender:**
| Value  | Count |
|--------|-------|
| Male   | 5,457 |
| Female | 4,543 |

Unexpected values found: No

---

## 6. Numerical Ranges
| Column          | Min   | Max        | Avg        |
|-----------------|-------|------------|------------|
| CreditScore     | 350   | 850        | 650.53     |
| Age             | 18    | 92         | 38.92      |
| Tenure          | 0     | 10         | —          |
| Balance         | 0.00  | 250,898.09 | 76,485.89  |
| NumOfProducts   | 1     | 4          | —          |
| EstimatedSalary | 11.58 | 199,992.48 | 100,090.24 |

---

## 7. Outliers
| Column      | Condition       | Count | Treatment              |
|-------------|-----------------|-------|------------------------|
| CreditScore | Outside 300–850 | 0     | No action required     |
| Age         | Outside 18–100  | 0     | No action required     |

---

## 8. Zero Balance Analysis
| Measure                         | Value  |
|---------------------------------|--------|
| Zero balance count              | 3,617  |
| Zero balance % of total         | 36.17% |
| Zero balance in retained group  | 3,117  |
| Zero balance % of retained      | 39.14% |
| Zero balance in churned group   | 500    |
| Zero balance % of churned       | 24.55% |

**Finding:** Zero balance customers are LESS likely to churn than
non-zero balance customers (24.55% vs ~13% implied for non-zero
churned). Zero balance is not a churn signal in this dataset —
counter-intuitive but data-confirmed.

Treatment: Retained per Assumption A1 — flagged as 'Zero Balance' tier.

---

## 9. Binary Column Validation
| Column         | Value 0 | Value 1 | Valid? |
|----------------|---------|---------|--------|
| HasCrCard      | 2,945   | 7,055   | ✅ Yes |
| IsActiveMember | 4,849   | 5,151   | ✅ Yes |

---

## 10. Schema Issue — Extra Columns
| Column   | Type    | Action                              |
|----------|---------|-------------------------------------|
| column14 | varchar | Excluded explicitly in Script 02    |
| column15 | varchar | Excluded explicitly in Script 02    |
| column16 | bigint  | Excluded explicitly in Script 02    |

These columns were not visible in Excel. DuckDB detected them as
trailing CSV artefacts. All three are excluded by name in the
SELECT statement of Script 02.

---

## 11. Assumptions Made
- **A1:** Zero-balance records retained and segmented — data confirms
  they are not a disproportionate churn risk (24.55% vs 39.14%
  in retained group)
- **A2:** CreditScore outliers outside 300–850 — 0 found, no removal needed
- **A3:** Age outliers outside 18–100 — 0 found, no removal needed
- **A4:** EstimatedSalary retained despite being estimated — flagged
  in limitations
- **A5:** Extra columns column14/15/16 are CSV artefacts — excluded
  at cleaning stage, not analytical data

---

*Clarivance Analytics Group | From Data to Decision | April 2026*