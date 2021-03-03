with query as (
    SELECT *

    FROM Canadian_Region_Consumers_2020_09_28

             JOIN region_health_dashboard

                  ON "Region Name" = "Region"
)

SELECT *,
      CAST("T30D MAU" AS DECIMAL)/nullif("Total Consumers", 0) as Consumer_Percentage

FROM query



