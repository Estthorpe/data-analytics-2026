# Data Dictionary — Project 02 | Mental Health in the Workplace

## Clarivance Analytics Group | Updated at each stage

---

## Source Dataset: UKHLS Wave 10 (j_indresp, j_hhresp, xwavedat)

### Key Variables Selected for Analysis

| Variable Name | Source File | Type | Description | Notes |
|---------------|-------------|------|-------------|-------|
| pidp | j_indresp | Integer | Permanent person ID — primary join key | Stable across all waves |
| hidp | j_indresp | Integer | Household ID — join key for j_hhresp | |
| j_ghq_casess_dv | j_indresp | Integer | GHQ-12 caseness score (0–12) | >=4 = probable common mental disorder |
| j_jbstat | j_indresp | Integer | Current economic activity / employment status | Coded: 1=SE, 2=employed, 3=unemployed... |
| j_jbterm | j_indresp | Integer | Job contract type | 1=permanent, 2=temporary, 97=other |
| j_jbsize | j_indresp | Integer | Employer size (number of employees) | Coded bands: 1=<10, 2=10-24... |
| j_jbsec | j_indresp | Integer | Perceived job security | 1=very likely to lose job... |
| j_jbsat | j_indresp | Integer | Overall job satisfaction | 1=completely dissatisfied... 7=completely satisfied |
| j_jbhrs | j_indresp | Integer | Hours worked per week in main job | |
| j_fimnlabgrs_dv | j_indresp | Float | Monthly gross labour income (derived) | GBP |
| j_sex | j_indresp | Integer | Sex | 1=male, 2=female |
| j_age_dv | j_indresp | Integer | Age (derived) | |
| j_racel_dv | j_indresp | Integer | Ethnicity (derived, detailed) | 1=White British... see UKHLS codebook |
| [Add remaining variables at Stage 3] | | | | |

### Engineered Features (Added at Stage 4)

| Feature Name | Formula | Purpose |
|--------------|---------|---------|
| ghq_case_flag | 1 if j_ghq_casess_dv >= 4, else 0 | Binary probable mental disorder indicator |
| treatment_flag | Constructed — see Stage 4 assumption log | Target variable: 1=has need, not seeking; 0=has need, seeking |
| precarity_index | 3=zero-hours, 2=temporary, 1=involuntary PT, 0=permanent | Ordinal employment precarity ranking |
| employer_support_score | Composite index — see Stage 4 documentation | Employer support environment score (0-1) |
| [Add remaining features at Stage 4] | | |

---

*Clarivance Analytics Group | From Data to Decision*
