-- ============================================================
-- Project:     Retail Banking Customer Churn Analysis
-- Prepared by: Clarivance Analytics Group
-- Stage:       Analytical Queries — Descriptive & Diagnostic
-- Date:        April 2026
-- Description: 10 analytical queries generating the descriptive
--              and diagnostic insights that feed into Power BI
--              and the Python notebook commentary.
--              Includes WINDOW FUNCTIONS, CASE WHEN tiering,
--              GROUP BY/HAVING, and a Pareto analysis.
--              All queries run against churn_clean — the verified
--              cleaned table produced by Script 02.
-- ============================================================
-- ── PRE-FLIGHT: CONFIRM CLEAN TABLE IS LOADED ───────────────
-- If this returns 0 rows, run Script 02 first to recreate
-- churn_clean before proceeding.
SELECT COUNT(*) AS rows_in_churn_clean,
    'Must be 10000' AS expected
FROM churn_clean;
-- ── QUERY A: OVERALL CHURN RATE ─────────────────────────────
-- Establishes the headline metric for the executive summary.
-- Every subsequent query is measured against this baseline.
SELECT COUNT(*) AS total_customers,
    SUM(Exited) AS total_churned,
    SUM(
        CASE
            WHEN Exited = 0 THEN 1
            ELSE 0
        END
    ) AS total_retained,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance_all,
    ROUND(
        AVG(
            CASE
                WHEN Exited = 1 THEN Balance
            END
        ),
        2
    ) AS avg_balance_churned,
    ROUND(
        AVG(
            CASE
                WHEN Exited = 0 THEN Balance
            END
        ),
        2
    ) AS avg_balance_retained
FROM churn_clean;
-- ── QUERY B: CHURN RATE BY GEOGRAPHY ────────────────────────
-- Audit confirmed Germany at 32.44% vs 16% for France/Spain.
-- This query adds revenue context — avg balance per geography
-- shows the financial weight behind the Germany churn problem.
SELECT Geography,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(
        SUM(
            CASE
                WHEN Exited = 1 THEN Balance
                ELSE 0
            END
        ),
        2
    ) AS total_balance_at_risk
FROM churn_clean
GROUP BY Geography
ORDER BY churn_rate_pct DESC;
-- ── QUERY C: CHURN RATE BY AGE BAND ─────────────────────────
-- Tests the hypothesis that 45-54 churns highest.
-- Cleaning output showed 35-44 is the largest segment —
-- size vs. rate distinction is critical for prioritisation.
SELECT age_band,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM churn_clean
GROUP BY age_band
ORDER BY CASE
        age_band
        WHEN '18-24' THEN 1
        WHEN '25-34' THEN 2
        WHEN '35-44' THEN 3
        WHEN '45-54' THEN 4
        WHEN '55-64' THEN 5
        ELSE 6
    END;
-- ── QUERY D: CHURN RATE BY NUMBER OF PRODUCTS ───────────────
-- Expected: 1-product customers churn most.
-- Critical finding — directly informs cross-sell
-- retention strategy recommendation.
SELECT NumOfProducts,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM churn_clean
GROUP BY NumOfProducts
ORDER BY NumOfProducts;
-- ── QUERY E: CHURN RATE BY ACTIVE MEMBER STATUS ─────────────
-- IsActiveMember expected to be the strongest single predictor.
-- Quantifies the churn rate multiplier between active/inactive.
SELECT CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS member_status,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM churn_clean
GROUP BY IsActiveMember
ORDER BY IsActiveMember;
-- ── QUERY F: CHURN RATE BY BALANCE TIER ─────────────────────
-- Tests whether balance level correlates with churn.
-- Audit finding: zero balance customers churn LESS —
-- this query shows whether that pattern holds across all tiers.
SELECT balance_tier,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(SUM(Balance), 2) AS total_balance
FROM churn_clean
GROUP BY balance_tier
ORDER BY churn_rate_pct DESC;
-- ── QUERY G: CHURN RATE BY ENGAGEMENT SCORE ─────────────────
-- Tests whether the composite engagement score (0-4) predicts
-- churn directionally — lower engagement = higher churn expected.
-- Validates the engineered feature before it enters the model.
SELECT engagement_score,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM churn_clean
GROUP BY engagement_score
ORDER BY engagement_score;
-- ── QUERY H: HIGH-RISK SEGMENT IDENTIFICATION ───────────────
-- Diagnostic query — finds the specific factor COMBINATIONS
-- with highest churn rates. This is the Tier 2 core finding.
-- HAVING COUNT(*) >= 50 ensures statistical credibility —
-- segments smaller than 50 customers are excluded.
SELECT Geography,
    age_band,
    CASE
        WHEN IsActiveMember = 1 THEN 'Active'
        ELSE 'Inactive'
    END AS member_status,
    NumOfProducts,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM churn_clean
GROUP BY Geography,
    age_band,
    IsActiveMember,
    NumOfProducts
HAVING COUNT(*) >= 50
ORDER BY churn_rate_pct DESC
LIMIT 15;
-- ── QUERY I: PARETO — BALANCE CONCENTRATION ─────────────────
-- Quantifies the revenue weight of churned vs retained customers.
-- Establishes the financial case for the retention programme —
-- what balance value is walking out the door?
SELECT CASE
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Retained'
    END AS customer_status,
    COUNT(*) AS customers,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_base,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(SUM(Balance), 2) AS total_balance,
    ROUND(
        SUM(Balance) * 100.0 / SUM(SUM(Balance)) OVER(),
        2
    ) AS pct_of_total_balance
FROM churn_clean
GROUP BY Exited
ORDER BY Exited DESC;
-- ── QUERY J: WINDOW FUNCTION — CHURN RANK BY SEGMENT ────────
-- Ranks every Geography × Age Band combination by churn rate.
-- Uses RANK() WINDOW FUNCTION — Clarivance SQL standard.
-- HAVING COUNT(*) >= 100 ensures only robust segments are ranked.
-- This ranking feeds directly into the Power BI diagnostic page.
SELECT Geography,
    age_band,
    COUNT(*) AS customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_pct,
    ROUND(AVG(Balance), 2) AS avg_balance,
    RANK() OVER (
        ORDER BY SUM(Exited) * 100.0 / COUNT(*) DESC
    ) AS churn_rank
FROM churn_clean
GROUP BY Geography,
    age_band
HAVING COUNT(*) >= 100
ORDER BY churn_rank;