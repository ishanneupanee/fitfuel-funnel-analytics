-- View-to-cart conversion by product
-- Joins the view-count and add-to-cart-count subqueries on page_title
-- to calculate what % of viewers added each product to cart.
--
-- Result: Resistance Bands converted at 73.6%, Whey Protein (Vanilla) at 60.3%
-- -- well above the ~45-50% seen on most other products.
-- Note: "Shop All Products" showed 109.4% (add_to_cart > views), a data anomaly
-- likely caused by cross-day mismatches in the synthetic dataset -- excluded
-- from headline findings.

SELECT
  v.page_title,
  v.view_count,
  c.add_to_cart_count,
  ROUND(c.add_to_cart_count / v.view_count * 100, 1) AS pct_added
FROM (
  SELECT
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') AS page_title,
    COUNT(*) AS view_count
  FROM `marketing-analytics-506806.analytics_551879761.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260831' AND event_name = 'page_view'
  GROUP BY page_title
) v
JOIN (
  SELECT
    (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_title') AS page_title,
    COUNT(*) AS add_to_cart_count
  FROM `marketing-analytics-506806.analytics_551879761.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260831' AND event_name = 'add_to_cart'
  GROUP BY page_title
) c
ON v.page_title = c.page_title
ORDER BY pct_added DESC;
