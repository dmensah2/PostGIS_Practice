  SELECT
    --columns
*
    --table
  FROM sf.sf_billing_contract_line_item_c a
    --table
      LEFT JOIN sf.sf_product2 b
      ON a.product__c = b.id

      LEFT JOIN sf.sf_region_c c
      ON b.region__c = c.id

  WHERE a.isactive__c ='t' AND a.isdeleted ='f'
