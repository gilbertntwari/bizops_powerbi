select 
concat(e.SAPDocEntry,e.ProductCode)as UniqueId,
e.inventoryTransactionDate as "Confirmed_Date",right(e.cause, LEN(e.cause) - 17) AS From_Warehouse,e.WarehouseName,e.ProductName,e.ProductCode,e.SAPDocEntry,e.ReferenceNumber as TMS_No,e.amount as Quantity
from  [clientdatabase].[reporting].[vERPLY_InventoryRegistrations] as e
where CreatorID = 517943 and CountryId=1