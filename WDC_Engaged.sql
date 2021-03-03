SELECT
date,
platform,
region,
SUM(users_engaged) AS users_engaged
FROM report.wdc_dau_engaged_v2
WHERE
      region != 'Total' AND
      region NOT LIKE 'CA - %' AND
      (platform LIKE '%iOS%' or platform LIKE '%Android%' or platform = 'Total')
GROUP BY date, platform, region