SELECT a."Store Name",
       a."Phone",
       a."Address"

FROM webscraped_dispensaries_20201019 a,
     salesforce_20201009 b

WHERE similarity(a."Store Name", b."Account Name") > .7
      and similarity (a."Address", b."Mailing Address") > .7