# Insights & Recommendations
## Project 01 — Retail Banking Customer Churn Analysis
## Clarivance Analytics Group | April 2026

---

## Section 1 — Key Insights

### Insight 1 — The Churn Problem is Geographically Concentrated

Germany churns at 32.44% — 2× the rate of France and Spain. Despite
representing only 25% of the total customer base, Germany produces 40%
of all churned customers. The average German customer holds £119,730 in
account balance — the highest of any geography — making this
concentration a premium revenue risk, not merely a volume problem.

**Business implication:** A Germany-first retention strategy is not
optional — it is the most efficient use of the retention budget. Every
£1 spent retaining a German customer protects more account value than
the same £1 spent on a French or Spanish customer.

---

### Insight 2 — Age is the Strongest Demographic Predictor

Customers aged 45–64 churn at 48–50% — nearly 2.5× the portfolio
average. This cohort is likely switching to competitors offering better
savings rates, mortgage deals, or digital banking experiences. They
have the financial means to move and the motivation to seek better value.

**Business implication:** The 45–64 segment must be treated as a
separate strategic priority. Standard retention messaging is unlikely
to work. This group requires personalised outreach, preferential rate
offers, and dedicated relationship manager contact.

---

### Insight 3 — Product Depth is the Strongest Behavioural Lever

The churn rate difference between one-product and two-product customers
(27.71% vs 7.58%) is the single most actionable finding in this
analysis. Moving a customer from one to two products reduces their
churn probability by 73%. This is not a correlation — it is a structural
relationship that drives direct retention outcomes.

**Business implication:** Cross-selling a second product to single-
product customers in the Intervene Now tier is the highest-ROI retention
action available. The incremental revenue from the second product is
additive to the retention benefit.

---

### Insight 4 — Inactivity is a Leading Indicator

Inactive members churn at 26.85% — 1.88× the rate of active members.
Inactivity precedes churn. A customer who stops using the bank's
digital services, stops logging in, stops transacting is signalling
disengagement before they formally close their account.

**Business implication:** Inactivity monitoring should be built into
the bank's CRM alerting. Any customer who has not logged into digital
banking in 60 days should trigger an automatic outreach workflow.
Re-activation is significantly cheaper than retention after the
churn decision has been made.

---

### Insight 5 — Zero Balance Customers are Not the Problem

Counter-intuitively, the 3,617 customers (36.17%) with zero account
balance churn at only 13.82% — the lowest rate of any balance tier.
This challenges the assumption that dormant or zero-balance accounts
represent high churn risk.

**Business implication:** Do not waste retention resources on zero-
balance customers. Redirect that budget toward High Balance (25.77%
churn) and Premium Balance (23.12% churn) customers — these represent
significantly more account value and higher churn rates.

---

### Insight 6 — The 3 and 4 Product Anomaly Signals Over-Selling

Customers with 3 products churn at 82.71% and customers with 4 products
churn at 100%. These rates are structurally different from the 1 and 2
product pattern and suggest these customers were sold products that did
not meet their needs.

**Business implication:** Review the sales process for customers sold
3+ products in the past 24 months. Conduct a root cause analysis on
this cohort — if over-selling is confirmed, a product rationalisation
and goodwill programme may be more effective than a standard retention
outreach.

---

## Section 2 — Prioritised Recommendations

### Priority 1 — IMMEDIATE: Deploy Risk Register to CRM

**Action:** Export the churn risk register CSV to the CRM system.
Assign the top 500 Intervene Now customers (churn probability ≥55%)
to named relationship managers for personal outreach within 5 business
days.

**Target segment:** Germany + age 45–64 + inactive + single product.
These 50 customers (Germany 55–64 inactive single-product) have a 96%
predicted churn rate and hold an average balance of £125,868.

**Expected outcome:** Relationship manager contact with the top 500
customers. Convert 30% to active status through re-engagement.

---

### Priority 2 — 30-DAY: Cross-Sell Campaign for Single-Product Customers

**Action:** Launch a targeted product cross-sell campaign for all
Intervene Now customers currently holding only one product.

**Offer design:** Tailor the offer to the customer's existing product.
Current account holder → offer cash ISA or savings account.
Mortgage holder → offer insurance or current account.

**Target volume:** Approximately 2,800 single-product customers in
the Intervene Now tier.

**Expected outcome:** 20% cross-sell conversion rate (560 customers
moved to 2 products). Based on the 7.58% vs 27.71% churn rate
differential, this is projected to retain approximately 112 customers
who would otherwise have churned — protecting approximately £10.2M
in account value.

---

### Priority 3 — 30-DAY: Re-Activation Programme for Inactive Members

**Action:** Identify all inactive members (IsActiveMember = 0) in the
Intervene Now tier. Deploy a digital re-activation sequence: email
campaign → push notification → relationship manager call escalation
for non-responders after 14 days.

**Target volume:** Approximately 2,400 inactive customers in the
Intervene Now tier.

**Expected outcome:** 25% re-activation rate (600 customers move from
inactive to active). Based on the 26.85% vs 14.27% churn rate
differential, this is projected to retain approximately 75 customers —
protecting approximately £6.8M in account value.

---

### Priority 4 — 90-DAY: Germany Relationship Programme

**Action:** Establish a dedicated Germany retention programme with
locally-relevant product offers, German-language communications, and
a quarterly relationship review call for all German customers aged
45+ with account balances above £80,000.

**Rationale:** Germany's 32.44% churn rate versus 16% for France/Spain
suggests a structural gap in the value proposition offered to German
customers — likely competitive pressure from local German banks
offering superior savings rates or digital experience.

**Expected outcome:** Reduce Germany churn rate from 32.44% to 25%
over 12 months — protecting approximately £19.4M in account value
annually from the German portfolio alone.

---

### Priority 5 — 90-DAY: Build Inactivity Early Warning System

**Action:** Implement automated CRM alerts triggered by customer
inactivity signals: no digital login in 30 days, no transaction in
60 days, or a drop in product usage below baseline.

**Rationale:** Inactivity precedes churn. Intervening at the inactivity
stage — before the customer has made the churn decision — is
significantly more effective and cheaper than post-decision retention.

**Expected outcome:** Identify at-risk customers 60–90 days earlier
than the current model allows, enabling lower-cost, higher-conversion
interventions before churn intent solidifies.

---

## Section 3 — What Would Improve This Analysis

The following data sources and enhancements would materially
strengthen the predictive model and business impact calculations:

- **Transaction-level data with timestamps:** Would enable true cohort
  analysis by calendar period and detection of behavioural change
  velocity — the rate at which a customer is becoming less engaged.

- **Customer service interaction history:** Complaint frequency,
  call centre contacts, and service recovery events are strong churn
  predictors not available in this dataset.

- **Competitor rate data:** Germany's elevated churn rate may be
  driven by a specific competitor offer. Linking internal churn data
  to competitor rate movements would allow predictive intervention
  before the competitor campaign reaches full penetration.

- **Product profitability data:** The revenue at risk calculation
  currently uses account balance as a proxy. Actual product margin
  data would allow more precise ROI calculations per intervention.

- **12+ months of longitudinal data:** The current model is a static
  snapshot. A rolling 12-month model with monthly retraining would
  capture seasonality, economic cycles, and the effect of prior
  retention interventions.

---

*Clarivance Analytics Group | From Data to Decision | April 2026*