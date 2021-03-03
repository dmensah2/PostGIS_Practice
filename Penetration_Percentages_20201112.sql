with license_table as (

SELECT a."Region Name",
       a."state" as State,
       a."Dispensary Listings",
       b."license_count" as "License Count",
       a."T30D MAU",
       c."total consumers" as "Total Consumers",
       d."Total Consumers" as "CA Total Consumers"

--Contains all licenses that have been mapped across 24 states (~7,000 records)
FROM public.region_health_dashboard_20201109 a

--Contains everything from Chartio in region health dash across all 50 states
LEFT JOIN public.region_licenses_mapped_20201005 b

    ON a."Region Name" = b."name"

LEFT JOIN usa_region_consumers_20201110 c

    ON a."Region Name" = c."region name"

LEFT JOIN "CA_Region_Consumers_20200928" d

    ON a."Region Name" = d."Region"
)

SELECT *,
       ROUND(CAST("Dispensary Listings" AS DECIMAL)/NULLIF("License Count", 2), 2) as "License Percentage",
       CASE
           WHEN NULLIF("Total Consumers", 0) IS NOT NULL
               THEN ROUND(CAST("T30D MAU" AS DECIMAL)/NULLIF("Total Consumers", 2), 2)
           WHEN NULLIF("CA Total Consumers", 0) IS NOT NULL
               THEN ROUND(CAST("T30D MAU" AS DECIMAL)/NULLIF("CA Total Consumers", 2), 2)
       END AS "Consumer Percentage"
FROM license_table