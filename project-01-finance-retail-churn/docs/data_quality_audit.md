# Data Quality Audit Report
## Project 01 — Retail Banking Customer Churn Analysis
## Prepared by: Clarivance Analytics Group | April 2026

---

## 1. Row Count
| Measure          | Value |
|------------------|-------|
| Raw rows         |       |
| Raw columns      | 14    |
| Expected rows    | 10,000 |
| Match expected?  |       |

---

## 2. Null Audit
| Column            | Null Count | Null % | Treatment |
|-------------------|------------|--------|-----------|
| CreditScore       | 0          | 0      | 0         |
| Geography         | 0          | 0      | 0         |
| Gender            | 0          | 0      | 0         |
| Age               | 0          | 0      | 0         |
| Tenure            | 0          | 0      | 0         |
| Balance           | 0          | 0      | 0         |
| NumOfProducts     | 0          | 0      | 0         |
| HasCrCard         | 0          | 0      | 0         |
| IsActiveMember    | 0          | 0      | 0         |
| EstimatedSalary   | 0          | 0      | 0         |
| Exited            | 0          | 0      | 0         |

---

## 3. Duplicate Records
- Duplicate CustomerIds found: [n]
- Treatment: [describe action taken]

---

## 4. Target Variable Distribution
| Exited | Count       |  Pct % |
|--------|-------------|-------|
| 0 (Retained) | 7,963 |79.63|
| 1 (Churned)  | 2,037 |20.37|

Class imbalance ratio: [X]:1 — handled via class_weight='balanced' in modelling.

---

## 5. Categorical Distributions
**Geography:**
| Value   | Count |
|---------|-------|
| France  | 5014  |
| Germany | 2509  |
| Spain   | 2477  |

Unexpected values found:  No

**Gender:**
| Value  | Count |
|--------|-------|
| Male   | 5,457 |
| Female | 4,543 |

Unexpected values found:  No

---

## 6. Numerical Ranges
| Column          | Min | Max    | Avg    |
|-----------------|-----|--------|--------|
| CreditScore     | 350 | 850    |650.53  |
| Age             | 18  | 92     |38.92   |
| Tenure          | 0   | 10     |        |
| Balance         |     |250,898 |76,485  |
| NumOfProducts   | 1   |  4     |        |
| EstimatedSalary |11.6 |199,992 | 100,090|

---

## 7. Outliers
| Column      | Condition          | Count | Treatment |
|-------------|--------------------|-------|-----------|
| CreditScore | Outside 300–850    |   0   | - |
| Age         | Outside 18–100     |   0   | - |

---

## 8. Zero Balance Analysis
| Measure                        | Value |
|--------------------------------|-------|
| Zero balance count             | 3,617 |
| Zero balance % of total        | 36.17 |
| Zero balance in churned group  | 3,117 |
| Zero balance in retained group |  500  |

Treatment: Retained per Assumption A1 — flagged as 'Zero Balance' tier.

---

## 9. Binary Column Validation
| Column         | Values Found | Valid? |
|----------------|--------------|--------|
| HasCrCard      | 7,055        |  100%  |
| IsActiveMember | 5,151        |  100%  |

---

## 10. Assumptions Made
- **A1:** Zero-balance records retained and segmented — not treated as errors
- **A2:** CreditScore outliers outside 300–850 removed — industry standard range
- **A3:** Age outliers outside 18–100 removed — reasonable customer age range
- **A4:** EstimatedSalary retained despite being estimated — flagged in limitations

---

*Clarivance Analytics Group | From Data to Decision | April 2026*