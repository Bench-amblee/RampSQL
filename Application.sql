-- Provide January 31's rolling 3 day average of total transaction amount processed per day

-- create CTE for sum of all transactions each day
WITH daily_totals AS (
    SELECT 
        DATE_TRUNC('day', transaction_time) AS transaction_date,
        SUM(transaction_amount) AS transaction_amount
    FROM transactions
    GROUP BY DATE_TRUNC('day', transaction_time)
)
SELECT 
    transaction_date, -- date of the transaction
    AVG(transaction_amount) OVER (ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg -- calculate rolling average over 3 days
FROM daily_totals
WHERE transaction_date = '2021-01-31'; -- filter for January 31st
