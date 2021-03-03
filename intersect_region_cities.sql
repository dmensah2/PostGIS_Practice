with main as (
with query as (
    SELECT a.name as city_name,
           a.namelsad,
           a.statefp,
           b.name,
           b.slug,
           a.geom


    FROM public."USA_Places_2020" a

             JOIN core.regions b
                  ON st_intersects(
                          st_transform(a.geom, 4326), st_transform(b.geometry, 4326))

    WHERE b."name" not in (
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
                           'Alabama',
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
        )
      AND b."name" NOT LIKE '%Do Not Use%'
)

SELECT a.*,
       b.stusps,
       b.name as region_name

FROM query a

JOIN tl_2020_us_state b

ON st_intersects(a.geom, b.geom)

WHERE b.stusps = 'CO')

SELECT
       city_name,
       region_name,
       namelsad,
       statefp,
       slug,
       stusps
FROM main




