WITH base AS (
SELECT anonymous_id, timestamp::timestamp, context_listing_id, context_listing_type FROM seg_web_weedmaps.pages WHERE CONVERT_TIMEZONE('UTC','AMERICA/LOS_ANGELES',timestamp)::date >= '2020-01-01' AND name IN ('Listing Details','Listing Menu')
UNION ALL
SELECT anonymous_id, timestamp::timestamp, context_listing_id, context_listing_type FROM seg_ios_weedmaps.screens WHERE CONVERT_TIMEZONE('UTC','AMERICA/LOS_ANGELES',timestamp)::date >= '2020-01-01' AND name IN ('Listing Details','Listing Menu')
UNION ALL
SELECT anonymous_id, timestamp::timestamp, context_listing_id, context_listing_type FROM seg_android_weedmaps.screens WHERE CONVERT_TIMEZONE('UTC','AMERICA/LOS_ANGELES',timestamp)::date >= '2020-01-01' AND name IN ('Listing Details','Listing Menu'))
, listings AS (
SELECT
a.id AS listing_id,
a.legacy_id,
type AS listing_type,
CASE WHEN custom_latitude IS NOT NULL THEN custom_latitude ELSE latitude END AS latitude,
CASE WHEN custom_longitude IS NOT NULL THEN custom_longitude ELSE longitude END AS longitude
FROM core.listings a
    LEFT JOIN core.addresses b ON isnull(a.legacy_id,a.id) = b.addressable_id AND lower(a.type) = lower(b.addressable_type)
WHERE a.type IN ('Dispensary','Delivery'))
, mapped AS (
SELECT
a.*,
b.*
FROM base a
    JOIN listings b ON a.context_listing_id = isnull(b.legacy_id,b.listing_id) AND lower(a.context_listing_type) = lower(b.listing_type)
    )
, aggregated AS (
SELECT
CONVERT_TIMEZONE('UTC','AMERICA/LOS_ANGELES',timestamp)::date AS date,
listing_id,
listing_type,
latitude,
longitude,
COUNT(DISTINCT anonymous_id) AS daily_visitors
FROM mapped
GROUP BY 1,2,3,4,5
    )
SELECT DATE_TRUNC('MONTH',date)::date AS month,
       listing_id,
       listing_type,
       latitude,
       longitude,
       SUM(daily_visitors) AS visits
FROM aggregated
GROUP BY 1,2,3,4,5