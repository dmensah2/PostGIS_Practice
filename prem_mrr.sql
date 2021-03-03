{\rtf1\ansi\ansicpg1252\cocoartf2578
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 with parents as (\
  SELECT DISTINCT parent_id\
  \
  FROM "weedmaps-admin".core_regions\
 \
  )\
  \
SELECT a.*, \
	   b.parent_id as parent_id2,\
       round(cast(c.prem_mrr_pe as numeric), 2) as premium_mrr_pe\
FROM "weedmaps-admin".core_regions a\
\
JOIN parents b\
\
ON a.parent_id = b.parent_id\
\
  JOIN "weedmaps-admin".regionhealth_20201215 c\
  \
  ON a.name = c.region_name\
\
\
WHERE (published_for_brands = true \
       OR published_for_deliveries = true \
       OR published_for_dispensaries = true \
       OR published_for_doctors = true \
       ) AND a.name not in (\
    'Earth',\
    'United States',\
    'Alberta',\
    'Yukon Territory',\
  	'Northwest Territories',\
    'British Columbia',\
    'Manitoba',\
    'Ontario',\
    'Quebec',\
    'Nova Scotia'\
    'Saskatchewan',\
    'Nunavut',\
    'Newfoundland and Labrador',\
  	'Mexico',\
    'Canada',\
    'Argentina',\
    'Uruguay',\
  	'Alabama'\
	'Alaska',\
    'Arizona',\
    'Arkansas',\
    'California',\
    'Colorado',\
    'Connecticut',\
    'Delaware',\
    'Florida',\
    'Georgia',\
    'Hawaii',\
    'Idaho',\
  	'Indiana',\
    'Illinois',\
    'Iowa',\
    'Kansas',\
    'Kentucky',\
    'Louisiana',\
    'Maine',\
    'Maryland',\
    'Massachusetts',\
    'Michigan',\
    'Minnesota',\
    'Mississippi',\
    'Missouri',\
    'Montana',\
    'Nebraska',\
    'Nevada',\
    'New Hampshire',\
    'New Jersey',\
    'New Mexico',\
    'New York',\
    'North Carolina',\
    'North Dakota',\
    'Ohio',\
    'Oklahoma',\
    'Oregon',\
    'Pennsylvania',\
    'Rhode Island',\
    'South Carolina',\
    'South Dakota',\
    'Tennessee',\
    'Texas',\
    'Utah',\
    'Vermont',\
    'Virginia',\
    'Washington',\
    'West Virginia',\
    'Wisconsin',\
    'Wyoming'\
) and a.name not like '%Brands%'\
 -- make sure we select only 'published' ones\
}