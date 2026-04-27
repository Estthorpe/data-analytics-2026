# Data Download Instructions — UKHLS Wave 10

## Dataset: Understanding Society (UK Household Longitudinal Study)
## Study Number: SN 6614
## Required Wave: Wave 10 (2018–2020, variable prefix: j_)

---

## Step 1 — Register for Access

1. Go to: https://ukdataservice.ac.uk
2. Click 'Register' — registration is free for non-commercial use
3. Complete the registration form (academic/portfolio/educational purpose)
4. Confirm your email address
5. Log in to your account

## Step 2 — Find and Download the Dataset

1. Go to: https://beta.ukdataservice.ac.uk/datacatalogue/studies/study?id=6614
2. Click 'Get Data' / 'Access Data'
3. Select download format: SPSS or Stata (.dta) — Stata recommended
4. Select Wave 10 files (prefix j_)
5. Download to your local machine and extract the ZIP

## Step 3 — Place Files in This Folder

Copy the following files into this data/raw/ folder:
- j_indresp.dta        (Primary individual respondent file — ~35,000 rows)
- j_hhresp.dta         (Household respondent file)
- xwavedat.dta         (Cross-wave stable characteristics)

## Step 4 — Verify Files Are in Place

From the project root, run:
  Get-ChildItem -Path data\raw\

You should see the .dta files listed alongside this instructions file.

---

## Licence Note

These data files are provided under the UK Data Service End User Licence.
They may not be redistributed, published, or committed to a public repository.
This instructions file is the only data/raw/ content committed to GitHub.

## Citation

University of Essex, Institute for Social and Economic Research. (2021).
Understanding Society: Waves 1-11, 2009-2020 and Harmonised BHPS: Waves 1-18, 1991-2009.
[data collection]. UK Data Service. SN: 6614.
http://doi.org/10.5255/UKDA-SN-6614-14
