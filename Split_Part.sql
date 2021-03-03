with query as (
SELECT a."Store Name",
       split_part(a."Store Name", '-',1) as "Store Name 2",
       a."Phone",
       a."Address",
       a."Source",
       b."Account Name",
       b."Mailing Address",
       b."Phone",
       b."State",
       b."Full Name",
       similarity(split_part(a."Store Name", '-',1), b."Account Name") as match_percentage

FROM salesforce_matching.webscraped_dispensaries_20201019 a,
     salesforce_matching.salesforce_20201009 b

WHERE similarity(split_part(a."Store Name", '-',1), b."Account Name") > .7)

select count(*)

from query