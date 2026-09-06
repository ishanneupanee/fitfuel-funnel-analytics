-- Landing page distribution
-- Uses the same UNNEST pattern to pull page_title, but filtered to session_start
-- events specifically -- this identifies the page each session began on, not
-- just any page viewed mid-session.
--
-- Result: 1,243 of 1,776 sessions (70%) landed on the homepage; every other
-- page accounted for under 150 sessions each.

SELECT
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') AS landing_page,
  COUNT(DISTINCT user_pseudo_id) AS sessions
FROM `marketing-analytics-506806.analytics_551879761.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260904' AND event_name = 'session_start'
GROUP BY landing_page
ORDER BY sessions DESC;
