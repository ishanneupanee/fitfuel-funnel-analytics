-- Add-to-cart count by page title
-- Same UNNEST pattern as 03_page_views_by_title.sql, filtered to add_to_cart events
-- instead of page_view -- shows which specific product pages actually generate cart adds.
--
-- Result: Only individual product pages appeared (no category pages) --
-- Resistance Bands (53) and Wellness Bundle (43) led.

SELECT
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') AS page_title,
  COUNT(*) AS add_to_cart_count
FROM `marketing-analytics-506806.analytics_551879761.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260831' AND event_name = 'add_to_cart'
GROUP BY page_title
ORDER BY add_to_cart_count DESC;
