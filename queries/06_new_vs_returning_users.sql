-- New vs. returning users
-- Compares each session_start event's timestamp to the user's very first-ever
-- timestamp (user_first_touch_timestamp). A match means this is their first-ever
-- visit ('New'); anything else is 'Returning'.
--
-- Result: 1,775 new users vs. 1 returning user -- 99.9% of traffic was
-- first-time visitors.

SELECT
  CASE WHEN user_first_touch_timestamp = event_timestamp THEN 'New' ELSE 'Returning' END AS user_type,
  COUNT(DISTINCT user_pseudo_id) AS users
FROM `marketing-analytics-506806.analytics_551879761.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260831' AND event_name = 'session_start'
GROUP BY user_type;
