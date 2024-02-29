select 
WarehouseCode,
Itemcode as ProductCode,
[clientdatabase].[reporting].[SAP_ErplyInvoices].Description as ProductName,
sum(Quantity) as DukaSales,
DocumentDate

from
[clientdatabase].[reporting].[SAP_ErplyInvoices] 
where CountryId=1 and Itemcode like '%COST%'
Group by WarehouseCode,Itemcode,Description,DocumentDate
