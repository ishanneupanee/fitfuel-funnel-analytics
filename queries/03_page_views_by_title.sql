-- Page views by page title
-- Page titles live inside the nested event_params field, not as a top-level column.
-- UNNEST(event_params) unfolds that nested list so the query can search it;
-- the subquery pulls out the value where key = 'page_title'.
--
-- Result: Homepage led with 1,363 views; category pages (Protein & Supplements,
-- Fitness Accessories, etc.) each drew 1,000+ views.

SELECT
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') AS page_title,
  COUNT(*) AS view_count
FROM `marketing-analytics-506806.analytics_551879761.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260831' AND event_name = 'page_view'
GROUP BY page_title
ORDER BY view_count DESC;
