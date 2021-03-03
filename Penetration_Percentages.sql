with license_table as (
    SELECT
           a."name",
           b."state",
           count(*) as total_licenses

    FROM public.core_regions a

    JOIN public.region_licenses_all_20201009 b

    ON st_intersects(a.geom, b.geom)

    WHERE a."name" not in (
        'Earth',
        'United States',
        'Alberta',
        'Yukon Territory',
        'Northwest Territories',
        'British Columbia',
        'Manitoba',
        'Ontario',
        'Quebec',
        'Nova Scotia'
        'Saskatchewan',
        'Nunavut',
        'Newfoundland and Labrador',
        'Mexico',
        'Canada',
        'Argentina',
        'Uruguay',
        'Alabama'
        'Alaska',
        'Arizona',
        'Arkansas',
        'California',
        'Colorado',
        'Connecticut',
        'Delaware',
        'Florida',
        'Georgia',
        'Hawaii',
        'Idaho',
        'Indiana',
        'Illinois',
        'Iowa',
        'Kansas',
        'Kentucky',
        'Louisiana',
        'Maine',
        'Maryland',
        'Massachusetts',
        'Michigan',
        'Minnesota',
        'Mississippi',
        'Missouri',
        'Montana',
        'Nebraska',
        'Nevada',
        'New Hampshire',
        'New Jersey',
        'New Mexico',
        'New York',
        'North Carolina',
        'North Dakota',
        'Ohio',
        'Oklahoma',
        'Oregon',
        'Pennsylvania',
        'Rhode Island',
        'South Carolina',
        'South Dakota',
        'Tennessee',
        'Texas',
        'Utah',
        'Vermont',
        'Virginia',
        'Washington',
        'West Virginia',
        'Wisconsin',
        'Wyoming'
    ) or a."name" NOT LIKE '%Do Not Use%'

    GROUP BY (a."geom", a.id,a."name", b."state")
)

SELECT *,
      CAST(b."Dispensary Listings" AS DECIMAL)/a."total_licenses" as License_Percentage,
      CAST( b."T30D MAU" AS DECIMAL)/c."total consumers" as Consumer_Percentage

FROM license_table a

JOIN region_health_dashboard b

ON a."name" = b."Region Name"

JOIN public.USA_region_consumers c

ON a."name" = c."region mapped"