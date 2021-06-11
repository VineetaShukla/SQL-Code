	Join of Faccount, Faccount_Ext, attr_data for SalesPerson and fp_TTZN.Salesperson for the name.

SELECT F.account_code, F.account_suffix, F.full_name, F.address, F.address_2, F.city, F.stateprovince, F.postalzip_code,
F.country, S.name, F.credit_limit_terms, FX.credit_limit, F.account_type, AT.value
FROM fp_TTZN.Faccount F
LEFT OUTER JOIN fp_TTZN.Faccount_Ext FX
ON F.rowid = FX.rowid
LEFT OUTER JOIN fp_TTZN.attr_data AT
ON F.rowid = AT.record_number
AND AT.filename = 'Faccount'
AND AT.attribute_name = 'SALESPER'
LEFT OUTER JOIN fp_TTZN.Salesperson S
ON AT.value = S.uid
WHERE F.account_type in ('G', 'C')