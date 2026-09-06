-- Purchases without a matching checkout
-- purchase_users (55) was illogically higher than begin_checkout_users (15).
-- This query isolates purchasers who have no matching begin_checkout event,
-- using a LEFT JOIN and filtering for unmatched rows (checkouts.user_pseudo_id IS NULL).
--
-- Result: 43 of 55 purchasers (78%) had no begin_checkout event.
-- Conclusion: flagged as a synthetic-data generation gap, not real behavior.
-- True checkout -> purchase conversions used in the report: 55 - 43 = 12.

SELECT
  COUNT(DISTINCT purchasers.user_pseudo_id) AS purchased_without_checkout
FROM (
  SELECT DISTINCT user_pseudo_id
  FROM `marketing-analytics-506806.analytics_551879761.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260904' AND event_name = 'purchase'
) AS purchasers
LEFT JOIN (
  SELECT DISTINCT user_pseudo_id
  FROM `marketing-analytics-506806.analytics_551879761.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20260828' AND '20260904' AND event_name = 'begin_checkout'
) AS checkouts
ON purchasers.user_pseudo_id = checkouts.user_pseudo_id
WHERE checkouts.user_pseudo_id IS NULL;
