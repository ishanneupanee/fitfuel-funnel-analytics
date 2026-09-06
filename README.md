# FitFuel Purchase Funnel & Marketing Analytics

A self-directed marketing analytics project analyzing on-site behavior for a demo fitness e-commerce store, using event-level data from GA4 exported to BigQuery.

**Analysis period:** Aug 28 – Aug 31, 2026
**Live demo site:** [(https://fitfuel-analytics-main.vercel.app/)]
**Live dashboard:** [(https://datastudio.google.com/reporting/f3966c65-45ba-41f9-bc34-ca43b6aee58d)]
**Full write-up:** see `FitFuel_Funnel_Analysis_Report.pdf`

## What this is

1. Built a demo fitness e-commerce site ("FitFuel") using [Lovable](https://lovable.dev) (AI-assisted)
2. Generated realistic synthetic user traffic with an AI-assisted Python script (page views, cart adds, checkouts, purchases)
3. Sent that traffic through Google Analytics 4
4. Analyzed the raw, event-level data directly in BigQuery SQL — no pre-aggregation
5. Built the dashboard in Google Looker Studio, connected live to BigQuery

## Key findings

- **The purchase funnel leaks hardest at checkout.** Of users who added a product to their cart, only 4% went on to start checkout — the single largest drop-off point in the entire funnel.
- **Data quality catch:** raw purchase counts (55) were higher than checkout-start counts (15) — logically impossible. A `LEFT JOIN` traced this to 43 purchase events with no matching checkout event, a gap in the synthetic-data generation script rather than real user behavior.
- **Product-level conversion varies widely.** Resistance Bands converted from view to cart at 73.6%, well above the ~50–60% seen on other products.
- **Traffic is almost entirely first-time visitors** — 99.9% new, virtually no returning-user behavior.
- **70% of sessions landed on the homepage** rather than a category or product page, suggesting limited use of targeted landing pages.

Full findings, methodology, and recommendations are in `FitFuel_Funnel_Analysis_Report.pdf`.

## Repo structure

```
queries/
  01_funnel_stage_user_counts.sql
  02_purchase_checkout_inconsistency.sql
  03_page_views_by_title.sql
  04_add_to_cart_by_page.sql
  05_view_to_cart_conversion_by_page.sql
  06_new_vs_returning_users.sql
  07_landing_page_sessions.sql
FitFuel_Funnel_Analysis_Report.pdf
```

Each query file includes a comment explaining what it does and the result it produced.

## Tools used

Python (synthetic data generation) · Google Analytics 4 · Google BigQuery (SQL) · Google Looker Studio (visualization) · Lovable (site build)
