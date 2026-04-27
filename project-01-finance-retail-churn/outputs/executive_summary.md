# Executive Summary — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group | Mid-Size UK Retail Bank | April 2026

---

### Situation

A mid-size UK retail bank engaged Clarivance Analytics Group to investigate
accelerating customer attrition, identify at-risk customers before they
defect, and quantify the revenue consequences of inaction. The board had
approved a retention budget but lacked the data to deploy it with precision.

---

### What We Found

**Finding 1 — Headline Churn Rate:**
20.37% of the active customer base churned in the analysis period —
2,037 customers lost from a base of 10,000. Churned customers hold a
25% higher average account balance than retained customers (£91,108 vs
£72,745), meaning the customers leaving are disproportionately the
higher-value ones. Total account balance lost to churn: £185.6 million.

**Finding 2 — Geographic Concentration:**
Germany churns at 32.44% — exactly 2× the rate of France (16.15%) and
Spain (16.67%). Germany represents 25% of the customer base but
generates 40% of all churned customers. The average account balance of
a German customer is £119,730 — the highest of any geography — placing
£97.9 million in total balance at risk from German churn alone. This is
not a portfolio-wide problem. It is a Germany problem.

**Finding 3 — Age Band Risk:**
The 55–64 age band churns at 49.83% — the highest rate of any segment
and 2.4× the portfolio average. The 45–54 band is close behind at
48.15%. These two bands combined represent 2,058 customers. Despite
representing only 20.6% of the customer base, they account for 48.8%
of all churned customers. Both bands hold above-average account balances
(£81,272 and £81,576 respectively), making them the highest-value
at-risk cohort.

**Finding 4 — Product Engagement is the Strongest Structural Predictor:**
Customers holding only one bank product churn at 27.71%. Customers with
two products churn at 7.58% — a 3.7× difference driven purely by
product depth. Customers with three or four products churn at 82.71%
and 100% respectively, signalling an over-selling problem in that
segment. Inactive members churn at 1.88× the rate of active members
(26.85% vs 14.27%). The composite engagement score shows a perfect
inverse relationship: score 1 customers churn at 34.54%, score 4
customers at 9.12%.

**Finding 5 — Highest-Risk Segment Intersection:**
The single most dangerous segment intersection is Germany + age 55–64 +
inactive + single product. This combination produces a 96% churn rate —
meaning 96 of every 100 customers in this profile are predicted to
leave. Germany + 45–54 + inactive + single product follows at 84.09%.
These are not edge cases — they are structural concentrations that a
targeted programme can directly address.

**Finding 6 — Predictive Model Performance:**
Our dual-model framework (Logistic Regression AUC 0.8327, Random Forest
AUC 0.8530) correctly ranks a churner above a non-churner 85.3% of the
time. The model has scored all 10,000 customers. 4,916 customers are
classified as Intervene Now (≥50% predicted churn probability),
representing £142.5 million in combined account value at risk. The
probability distribution is bimodal — customers are either clearly
low-risk (8–17%) or clearly high-risk (50–57%) with no ambiguous
middle ground, making targeting straightforward.

---

### Our Recommendation

1. **Immediate (Week 1):** Deploy relationship manager outreach to the
   top 500 highest-probability customers in the Intervene Now tier —
   specifically Germany + age 45–64 + inactive + single product.
   These customers have predicted churn probabilities of 84–96% and
   hold average balances above £118,000. Export the ranked risk
   register to your CRM system this week.

2. **30-day:** Launch a cross-sell campaign targeting all single-product
   customers in the Intervene Now tier. Our data shows moving a customer
   from one to two products reduces churn probability from 27.71% to
   7.58%. At scale across 4,916 at-risk customers, even a 20% cross-sell
   conversion rate would materially reduce projected attrition.

3. **90-day:** Implement a re-activation programme for the 4,849
   inactive members across all geographies. Inactive status is the
   strongest single behavioural predictor of churn — 1.88× the active
   member rate. Targeted digital re-engagement (online banking
   activation, mobile app onboarding, relationship check-in calls)
   addresses this at scale with low cost per contact.

---

### Estimated Business Impact

Retaining 60% of the 4,916 Intervene Now customers at an estimated
programme cost of £245,800 (£50 per customer) is projected to protect
£85.5 million in account value — a **347:1 return on investment**.
Even under conservative assumptions — retaining only 20% of at-risk
customers at £100 per customer — the programme protects £28.5 million
at a cost of £491,600, delivering a **58:1 ROI**.
The business case for acting is unambiguous at any reasonable
programme cost assumption.

---

*Clarivance Analytics Group | From Data to Decision | April 2026*