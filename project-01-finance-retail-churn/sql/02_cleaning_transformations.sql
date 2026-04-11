-- ============================================================
-- Project:     Retail Banking Customer Churn Analysis
-- Prepared by: Clarivance Analytics Group
-- Stage:       Data Cleaning & Transformation
-- Date:        April 2026
-- Description: Cleans raw churn data, excludes non-analytical
--              columns including 3 trailing CSV artefact columns
--              detected at audit stage (column14, column15,
--              column16). Engineers 5 derived features for
--              segmentation and Power BI visualisation.
--              Exports clean CSV for Python modelling.
-- ============================================================
-- ── 1. VERIFY RAW SOURCE BEFORE CLEANING ────────────────────
-- Confirms we are reading the correct file and row count
-- matches the audit baseline of 10,000 rows.
SELECT COUNT(*) AS raw_row_count,
    'Expected: 10000' AS expected
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
-- ── 2. CREATE CLEANED TABLE ──────────────────────────────────
-- Columns explicitly selected by name — NOT SELECT *.
-- Reason: audit detected 3 extra artefact columns (column14,
-- column15, column16) that must be excluded.
-- RowNumber, CustomerId, Surname dropped — no analytical value.
-- PII (Surname) removed per data handling standards.
CREATE OR REPLACE TABLE churn_clean AS
SELECT CreditScore,
    Geography,
    Gender,
    Age,
    Tenure,
    Balance,
    NumOfProducts,
    HasCrCard,
    IsActiveMember,
    EstimatedSalary,
    Exited,
    -- ── ENGINEERED FEATURE 1: AGE BAND ───────────────────────
    -- Derived from: Age
    -- Purpose: Enables cohort segmentation in Power BI.
    -- Bands align to standard retail banking customer lifecycle
    -- stages. 45-54 band expected to show highest churn based
    -- on audit's Germany signal — hypothesis to test in EDA.
    CASE
        WHEN Age < 25 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS age_band,
    -- ── ENGINEERED FEATURE 2: BALANCE TIER ───────────────────
    -- Derived from: Balance
    -- Purpose: Segments dormant (zero) vs. value accounts.
    -- Audit confirmed 3,617 zero-balance records (36.17%).
    -- Zero balance proved LESS likely to churn (24.55%) —
    -- this tier will surface that finding visually in Power BI.
    CASE
        WHEN Balance = 0 THEN 'Zero Balance'
        WHEN Balance < 50000 THEN 'Low Balance'
        WHEN Balance BETWEEN 50000 AND 100000 THEN 'Mid Balance'
        WHEN Balance BETWEEN 100001 AND 150000 THEN 'High Balance'
        ELSE 'Premium Balance'
    END AS balance_tier,
    -- ── ENGINEERED FEATURE 3: CREDIT BAND ────────────────────
    -- Derived from: CreditScore
    -- Purpose: Human-readable banding for Power BI visuals.
    -- Audit confirmed range 350–850 — no outliers to handle.
    -- 'Poor' band starts at 350 (audit min) not 300 (standard
    -- lower bound) — no records exist below 350 in this dataset.
    CASE
        WHEN CreditScore < 500 THEN 'Poor'
        WHEN CreditScore BETWEEN 500 AND 599 THEN 'Fair'
        WHEN CreditScore BETWEEN 600 AND 699 THEN 'Good'
        WHEN CreditScore BETWEEN 700 AND 799 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_band,
    -- ── ENGINEERED FEATURE 4: ENGAGEMENT SCORE ───────────────
    -- Derived from: IsActiveMember + HasCrCard + NumOfProducts
    -- Purpose: Composite behavioural engagement index (range 0–4).
    -- LEAST(NumOfProducts, 2) caps the products contribution at 2
    -- so a customer with 4 products does not score disproportionately
    -- higher than one with 2. Activity and card holding weighted
    -- equally alongside product depth.
    -- Formula: IsActiveMember(0/1) + HasCrCard(0/1) + LEAST(NumOfProducts,2)
    (
        IsActiveMember + HasCrCard + LEAST(NumOfProducts, 2)
    ) AS engagement_score,
    -- ── ENGINEERED FEATURE 5: TENURE BAND ────────────────────
    -- Derived from: Tenure
    -- Purpose: Groups customers into relationship lifecycle stages.
    -- Audit confirmed range 0–10 — no outliers.
    -- Used as cohort proxy since no calendar date is available
    -- in this dataset (documented as Assumption A2 in audit).
    CASE
        WHEN Tenure <= 2 THEN 'New (0-2 yrs)'
        WHEN Tenure <= 5 THEN 'Developing (3-5 yrs)'
        WHEN Tenure <= 8 THEN 'Established (6-8 yrs)'
        ELSE 'Long-term (9-10 yrs)'
    END AS tenure_band
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
WHERE -- No nulls found at audit — WHERE clause retained as a
    -- defensive safeguard in case of upstream data changes.
    CreditScore IS NOT NULL
    AND Age IS NOT NULL
    AND Exited IS NOT NULL -- No outliers found at audit — bounds retained as safeguard.
    AND CreditScore BETWEEN 300 AND 850
    AND Age BETWEEN 18 AND 100;
-- ── 3. POST-CLEANING VERIFICATION ───────────────────────────
-- Row count must match raw count — no records should be lost
-- given zero nulls and zero outliers found at audit stage.
SELECT COUNT(*) AS cleaned_row_count,
    'Expected: 10000' AS expected,
    CASE
        WHEN COUNT(*) = 10000 THEN '✅ Row count verified'
        ELSE '❌ Row count mismatch — investigate'
    END AS status
FROM churn_clean;
-- ── 4. ENGINEERED FEATURES VERIFICATION ─────────────────────
-- Confirms all 5 derived columns contain expected values only.
-- Any NULL in engineered columns = logic gap in CASE statements.
-- Age band distribution
SELECT age_band,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM churn_clean
GROUP BY age_band
ORDER BY age_band;
-- Balance tier distribution
SELECT balance_tier,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM churn_clean
GROUP BY balance_tier
ORDER BY pct DESC;
-- Credit band distribution
SELECT credit_band,
    COUNT(*) AS customers
FROM churn_clean
GROUP BY credit_band
ORDER BY credit_band;
-- Engagement score distribution
SELECT engagement_score,
    COUNT(*) AS customers
FROM churn_clean
GROUP BY engagement_score
ORDER BY engagement_score;
-- Tenure band distribution
SELECT tenure_band,
    COUNT(*) AS customers
FROM churn_clean
GROUP BY tenure_band
ORDER BY tenure_band;
-- NULL check on all engineered columns — expect 0 across all
SELECT SUM(
        CASE
            WHEN age_band IS NULL THEN 1
            ELSE 0
        END
    ) AS null_age_band,
    SUM(
        CASE
            WHEN balance_tier IS NULL THEN 1
            ELSE 0
        END
    ) AS null_balance_tier,
    SUM(
        CASE
            WHEN credit_band IS NULL THEN 1
            ELSE 0
        END
    ) AS null_credit_band,
    SUM(
        CASE
            WHEN engagement_score IS NULL THEN 1
            ELSE 0
        END
    ) AS null_engagement,
    SUM(
        CASE
            WHEN tenure_band IS NULL THEN 1
            ELSE 0
        END
    ) AS null_tenure_band
FROM churn_clean;
-- ── 5. EXPORT CLEAN CSV FOR PYTHON ──────────────────────────
-- Exports the verified clean table to the cleaned data folder.
-- This file is the single source of truth for all downstream
-- Python analysis and Power BI work.
COPY churn_clean TO 'data/cleaned/bank_churn_clean.csv' (HEADER, DELIMITER ',');
SELECT 'Clean CSV exported successfully' AS status,
    'data/cleaned/bank_churn_clean.csv' AS location;