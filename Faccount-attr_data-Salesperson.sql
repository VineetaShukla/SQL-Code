-- Join of Faccount, Faccount_Ext, attr_data for SalesPerson and fp_TTZN.Salesperson for the name.
use fp_DEMO;

SELECT F.account_code, F.account_suffix, F.full_name, F.address, F.address_2, F.city, F.stateprovince, F.postalzip_code,
F.country, S.name, F.credit_limit_terms, FX.credit_limit, F.account_type, AT.value
FROM Faccount F
LEFT OUTER JOIN Faccount_Ext FX
    ON F.rowid = FX.rowid
LEFT OUTER JOIN attr_data AT
    ON F.rowid = AT.record_number
    AND AT.filename = 'Faccount'
    AND AT.attribute_name = 'SALESPER'
LEFT OUTER JOIN Salesperson S
    ON AT.value = S.uid
WHERE F.account_type in ('G', 'C');

