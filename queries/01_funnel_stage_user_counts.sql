-- Funnel stage user counts
-- Counts unique users who reached each stage of the purchase funnel.
-- CASE WHEN isolates rows matching each event type;
-- COUNT(DISTINCT user_pseudo_id) avoids counting the same user twice.
--
-- Result: 1,776 -> 1,287 -> 338 -> 15 -> 55
-- (purchase count investigated further in query 02 — see note there)

SELECT
  COUNT(DISTINCT CASE WHEN event_name = 'page_view' THEN user_pseudo_id END) AS page_view_users,
  COUNT(DISTINCT CASE WHEN event_name = 'view_item' THEN user_pseudo_id END) AS view_item_users,
  COUNT(DISTINCT CASE WHEN event_name = 'add_to_cart' THEN user_pseudo_id END) AS add_to_cart_users,
  COUNT(DISTINCT CASE WHEN event_name = 'begin_checkout' THEN user_pseudo_id END) AS begin_checkout_users,
  COUNT(DISTINCT CASE WHEN event_name = 'purchase' THEN user_pseudo_id END) AS purchase_users
FROM `marketing-analytics-506806.analytics_551879761.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260904';
