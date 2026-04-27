# Retail Banking Customer Churn Analysis — Decision Brief

**Prepared by:** Clarivance Analytics Group
**Date:** April 2026 | **Client:** Mid-Size UK Retail Bank

---

## The Problem

Customer attrition has accelerated materially over 18 months, eroding
revenue and increasing the cost of acquisition needed to replace lost
accounts. The board approved a retention budget but lacked the customer-
level data to deploy it with precision — resulting in blanket, non-
targeted retention spend with no measurable ROI.

## Our Approach

We analysed 10,000 customer records using DuckDB SQL segmentation,
Python-based exploratory analysis, and a dual-model predictive
framework (Logistic Regression + Random Forest, AUC 0.853) to generate
a churn probability score for every active customer, segmented into
actionable retention tiers.

## What the Data Revealed

- **20.37% overall churn rate** — churned customers hold 25% higher
  average balances than retained customers (£91,108 vs £72,745),
  meaning higher-value customers are leaving at disproportionate rates

- **Germany is the primary risk concentration** — churning at 32.44%,
  2× the France/Spain rate, with £97.9M in total balance at risk;
  the Germany + 45–64 + inactive + single-product intersection
  produces churn rates of 84–96%

- **Product depth and engagement are the actionable levers** —
  single-product customers churn at 27.71% vs 7.58% for two-product
  customers; inactive members churn at 1.88× the active member rate;
  the composite engagement score shows a perfect inverse relationship
  with churn across all four score levels

- **4,916 customers are classified as Intervene Now** (≥50% predicted
  churn probability), representing £142.5M in combined account value;
  the model achieves AUC-ROC of 0.853 — correctly ranking a churner
  above a non-churner 85.3% of the time

## Our Recommendation

Deploy a three-tier retention programme immediately: direct relationship
manager outreach for the top Intervene Now customers in Germany aged
45–64, a cross-sell campaign targeting all single-product Intervene Now
customers, and a re-activation programme for the 4,849 inactive members
across all geographies. Prioritise Germany first — it generates 40% of
all churned customers despite representing 25% of the base.

## Estimated Business Impact

Retaining 60% of Intervene Now customers at £50 per customer
(programme cost: £245,800) is projected to protect **£85.5M in account
value** — a **347:1 return on investment**. Under conservative
assumptions (20% retention, £100 per customer), the programme still
delivers a **58:1 ROI**.

---

*Clarivance Analytics Group | From Data to Decision | April 2026*