-- Name / student ID: NARDOUX Sacha

-- Q1. Write one SELECT below.

SELECT COUNT(DISTINCT s.user_id) AS active_users
FROM sessions AS s
JOIN users AS u ON u.user_id = s.user_id
WHERE s.session_start >= TIMESTAMP '2026-09-01'
    AND s.session_start < TIMESTAMP '2026-10-01';

Active Users : 14087

-- Q2. Write one SELECT below.

SELECT
    c.category,
    SUM(e.watch_seconds) AS total_watch_seconds
FROM events AS e
JOIN content AS c
    ON c.content_id = e.content_id
WHERE e.event_time >= TIMESTAMP '2026-01-01'
  AND e.event_time < TIMESTAMP '2027-01-01'
GROUP BY c.category
HAVING SUM(e.watch_seconds) > 100000
ORDER BY total_watch_seconds DESC;

Science	37642521
Culture	37529243
News	37431498
Sport	37412671
Travel	37298713
Technology	37170511

-- Q3. Corrected SELECT below; explanation in submission/answers.md.

SELECT u.country, SUM(su.monthly_price) AS monthly_subscription_value
FROM users AS u
JOIN subscriptions AS su
    ON su.user_id = u.user_id
WHERE su.start_date <= DATE '2026-09-01'
  AND (su.end_date IS NULL OR su.end_date > DATE '2026-09-01')
GROUP BY u.country
ORDER BY u.country;

France	10010.00
Germany	9990.00
Italy	9995.00
Portugal	10000.00
Spain	9990.00

-- Q4. Corrected SELECT below; explanation in submission/answers.md.

SELECT DATE_TRUNC('month', u.signup_date)::date AS signup_month, COUNT(DISTINCT u.user_id) AS registered_users, COUNT(DISTINCT s.user_id) AS september_active_users
FROM users AS u
LEFT JOIN sessions AS s
    ON s.user_id = u.user_id
   AND s.session_start >= TIMESTAMP '2026-09-01'
   AND s.session_start < TIMESTAMP '2026-10-01'
GROUP BY DATE_TRUNC('month', u.signup_date)::date
ORDER BY signup_month;

2025-03-01	1700	1204
2025-04-01	1644	1149
2025-05-01	1700	1191
2025-06-01	1644	1164
2025-07-01	1699	1186
2025-08-01	1698	1196
2025-09-01	1642	1168
2025-10-01	1699	1189
2025-11-01	1642	1161
2025-12-01	1698	1204

-- Q5A. Corrected SELECT below; explanation in submission/answers.md.

SELECT u.user_id, COUNT(s.user_id) AS session_count
FROM users AS u
LEFT JOIN sessions AS s
    ON s.user_id = u.user_id
GROUP BY u.user_id
ORDER BY u.user_id;

-- Q5B. Corrected SELECT below; explanation in submission/answers.md.

SELECT session_id, user_id, session_start,
    LAG(session_start) OVER (
        PARTITION BY user_id
        ORDER BY session_start, session_id
    ) AS previous_session
FROM sessions;

-- Q5C. Proposed DDL, if applicable, below; reasoning in answers.md.

-- BONUS (optional). ALTER the existing subscriptions_bonus table below.
-- Do not reset or replace the table. Run the bonus separately from your SELECTs.
