-- ============================================================
-- Project:     Retail Banking Customer Churn Analysis
-- Prepared by: Clarivance Analytics Group
-- Stage:       Data Quality Audit
-- Date:        April 2026
-- Description: Full data quality assessment of raw churn dataset.
--              Documents row counts, nulls, duplicates, outliers,
--              and value distributions before any cleaning begins.
-- ============================================================
-- ── 1. ROW COUNT & SHAPE ────────────────────────────────────
-- Expected: 10,000 rows, 14 columns
-- Confirms the dataset matches the Kaggle description before
-- any further work proceeds.
SELECT COUNT(*) AS total_rows
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
DESCRIBE
SELECT *
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
-- ── 2. NULL AUDIT ───────────────────────────────────────────
-- Check every analytical column for nulls.
-- Clarivance standard: flag anything above 5% null rate.
-- RowNumber, CustomerId, Surname excluded — they are dropped
-- at cleaning stage and have no analytical value.
SELECT COUNT(*) AS total_rows,
    SUM(
        CASE
            WHEN CreditScore IS NULL THEN 1
            ELSE 0
        END
    ) AS null_creditscore,
    SUM(
        CASE
            WHEN Geography IS NULL THEN 1
            ELSE 0
        END
    ) AS null_geography,
    SUM(
        CASE
            WHEN Gender IS NULL THEN 1
            ELSE 0
        END
    ) AS null_gender,
    SUM(
        CASE
            WHEN Age IS NULL THEN 1
            ELSE 0
        END
    ) AS null_age,
    SUM(
        CASE
            WHEN Tenure IS NULL THEN 1
            ELSE 0
        END
    ) AS null_tenure,
    SUM(
        CASE
            WHEN Balance IS NULL THEN 1
            ELSE 0
        END
    ) AS null_balance,
    SUM(
        CASE
            WHEN NumOfProducts IS NULL THEN 1
            ELSE 0
        END
    ) AS null_numproducts,
    SUM(
        CASE
            WHEN HasCrCard IS NULL THEN 1
            ELSE 0
        END
    ) AS null_hascrcard,
    SUM(
        CASE
            WHEN IsActiveMember IS NULL THEN 1
            ELSE 0
        END
    ) AS null_isactivemember,
    SUM(
        CASE
            WHEN EstimatedSalary IS NULL THEN 1
            ELSE 0
        END
    ) AS null_estimatedsalary,
    SUM(
        CASE
            WHEN Exited IS NULL THEN 1
            ELSE 0
        END
    ) AS null_exited
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
-- ── 3. DUPLICATE CHECK ──────────────────────────────────────
-- CustomerIds must be unique — any duplicate is a data error.
-- A result set with zero rows = no duplicates (expected outcome).
SELECT CustomerId,
    COUNT(*) AS occurrences
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY CustomerId
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;
-- ── 4. TARGET VARIABLE DISTRIBUTION ────────────────────────
-- Documents the class imbalance ratio.
-- Critical input to modelling decisions — class_weight='balanced'
-- will be applied because of this imbalance.
SELECT Exited,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY Exited
ORDER BY Exited;
-- ── 5. CATEGORICAL VALUE DISTRIBUTIONS ─────────────────────
-- Confirms Geography and Gender contain only expected values.
-- Any unexpected value here requires a cleaning decision before
-- proceeding.
SELECT Geography,
    COUNT(*) AS count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY Geography
ORDER BY count DESC;
SELECT Gender,
    COUNT(*) AS count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY Gender
ORDER BY count DESC;
-- ── 6. NUMERICAL RANGE SCAN ─────────────────────────────────
-- Documents min, max, and average across all numerical columns.
-- Establishes the baseline before outlier removal.
SELECT MIN(CreditScore) AS min_creditscore,
    MAX(CreditScore) AS max_creditscore,
    ROUND(AVG(CreditScore), 2) AS avg_creditscore,
    MIN(Age) AS min_age,
    MAX(Age) AS max_age,
    ROUND(AVG(Age), 2) AS avg_age,
    MIN(Tenure) AS min_tenure,
    MAX(Tenure) AS max_tenure,
    MIN(Balance) AS min_balance,
    MAX(Balance) AS max_balance,
    ROUND(AVG(Balance), 2) AS avg_balance,
    MIN(NumOfProducts) AS min_products,
    MAX(NumOfProducts) AS max_products,
    MIN(EstimatedSalary) AS min_salary,
    MAX(EstimatedSalary) AS max_salary,
    ROUND(AVG(EstimatedSalary), 2) AS avg_salary
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
-- ── 7. OUTLIER FLAGS ────────────────────────────────────────
-- CreditScore valid range: 300–850 (industry standard)
-- Age valid range: 18–100 (reasonable customer range)
-- Records outside these ranges are removed at cleaning stage.
SELECT COUNT(*) AS outlier_creditscore_count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
WHERE CreditScore < 300
    OR CreditScore > 850;
SELECT COUNT(*) AS outlier_age_count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
WHERE Age < 18
    OR Age > 100;
-- ── 8. ZERO BALANCE ANALYSIS ────────────────────────────────
-- Zero balance may indicate dormant accounts.
-- Assumption A1 (Project Brief): zero-balance records are RETAINED
-- and flagged as a distinct segment — not removed.
-- This query documents the scale of that decision.
SELECT SUM(
        CASE
            WHEN Balance = 0 THEN 1
            ELSE 0
        END
    ) AS zero_balance_count,
    ROUND(
        SUM(
            CASE
                WHEN Balance = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS zero_balance_pct
FROM read_csv_auto('data/raw/bank_churn_raw.csv');
-- Zero balance split by churn status
-- Key diagnostic: are zero-balance customers more likely to churn?
SELECT Exited,
    SUM(
        CASE
            WHEN Balance = 0 THEN 1
            ELSE 0
        END
    ) AS zero_balance_count,
    COUNT(*) AS total_in_group,
    ROUND(
        SUM(
            CASE
                WHEN Balance = 0 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS zero_balance_pct
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY Exited
ORDER BY Exited;
-- ── 9. BINARY COLUMN VALIDATION ─────────────────────────────
-- HasCrCard and IsActiveMember must contain only 0 and 1.
-- Any other value is a data integrity failure.
SELECT HasCrCard,
    COUNT(*) AS count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY HasCrCard
ORDER BY HasCrCard;
SELECT IsActiveMember,
    COUNT(*) AS count
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY IsActiveMember
ORDER BY IsActiveMember;
-- ── 10. WINDOW FUNCTION — CHURN RATE BY GEOGRAPHY ───────────
-- Demonstrates WINDOW FUNCTION technique (Clarivance SQL standard).
-- Shows each geography's churn rate alongside the portfolio average
-- in a single query — no subquery needed.
SELECT Geography,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(
        AVG(SUM(Exited) * 100.0 / COUNT(*)) OVER (),
        2
    ) AS portfolio_avg_churn_pct
FROM read_csv_auto('data/raw/bank_churn_raw.csv')
GROUP BY Geography
ORDER BY churn_rate_pct DESC;