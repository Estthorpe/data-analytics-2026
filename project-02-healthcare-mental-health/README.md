# Project 02 | Healthcare — Mental Health in the Workplace

## Clarivance Analytics Group

> **Client Brief:** An occupational health consultancy engaged Clarivance Analytics Group to
> identify which workforce segments face the highest barriers to mental health treatment-seeking,
> and to quantify the structural employer characteristics driving the support gap.

---

## Objective

Build a full-stack workforce mental health analytics solution — from raw survey data ingestion
through to a predictive risk model and executive-ready Power BI dashboard identifying the
highest-priority employer intervention targets.

## Dataset

- **Source:** Understanding Society (UKHLS) — UK Longitudinal Household Study, Wave 10 (2018–2020)
- **Access:** UK Data Service — registration required at ukdataservice.ac.uk (free, non-commercial)
- **Study Number:** SN 6614
- **Licence:** UK Data Service End User Licence — non-commercial portfolio and educational use
- **Size:** ~35,000 individual respondents (Wave 10); ~18,000–20,000 after employment filter
- **Key measure:** GHQ-12 (General Health Questionnaire-12) — validated population-level mental
  health screening tool. Score >=4 indicates probable common mental disorder (screening threshold
  only — not a clinical diagnosis).

> **Important:** Raw data files are not included in this repository in compliance with UK Data
> Service licence terms. See data/raw/download_instructions.md for access instructions.

## Tools Used

\`SQL (DuckDB)\` \`Python (Pandas, Scikit-learn, Seaborn)\` \`Power BI\` \`Excel\`

## Methodology

| Tier | Approach |
|------|----------|
| Descriptive | GHQ-12 score distributions, treatment-seeking rates by employer size, contract type, demographics |
| Diagnostic | Root cause segmentation — job precarity, employer size, perceived insecurity vs. actual contract type |
| Predictive | Random Forest Classifier — probability of probable unmet mental health need by worker profile |
| Prescriptive | Employer Support Environment Score, intervention priority ranking, What-If ROI simulator |
| Narrative | Executive summary + Decision Document with quantified productivity cost of inaction |

## Key Findings

- [Finding 1 — complete at Stage 7]
- [Finding 2]
- [Finding 3]
- [Finding 4]
- [Finding 5]

## How to Reproduce

1. Register at ukdataservice.ac.uk and download UKHLS Wave 10 (SN 6614)
2. Follow instructions in data/raw/download_instructions.md
3. Run SQL scripts in sql/ in order (01 -> 02 -> 03) using DuckDB
4. Open notebooks/mental_health_analysis.ipynb and run all cells
5. Open dashboard/mental_health_dashboard.pbix in Power BI Desktop

## Limitations

See docs/limitations_and_next_steps.md for full limitations, assumptions, and next steps.

---

## Sensitivity Disclosure

This project analyses self-reported mental health data from a nationally representative UK survey.
All data is anonymised and aggregated — no individual-level findings are reported. GHQ-12 scores
are used as a validated population-level screening indicator, not as clinical diagnoses. All
findings are associational — cross-sectional data does not support causal inference.

---

*Clarivance Analytics Group | From Data to Decision*
"@