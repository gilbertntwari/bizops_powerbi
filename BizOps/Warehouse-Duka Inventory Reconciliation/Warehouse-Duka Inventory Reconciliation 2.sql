Select concat(dt.DocEntry,dt.ITEMCODE) as UniqueId,
	dt.TRNSFRDATE as TransferDate,
	SUBSTRING(dt.TMS_No, PATINDEX('%[0-9]%', dt.TMS_No), PATINDEX('%[0-9][^0-9]%', dt.TMS_No + 't') - PATINDEX('%[0-9]%', 
                    dt.TMS_No) + 1) AS TNumber,	
	dt.TMS_No,
	dt.DocEntry,
	dt.From_Warehouse,
	dt.To_Bin_Location as To_Duka,
         dt.DukaName,
	dt.ITEMNAME as ProductName,
	dt.ITEMCODE as ProductCode,
	(Case when dt.To_Bin_Location like '%GOOD%' then dt.BinQuantity else 0 end) As Qty_In_GoodBin,
		(Case when dt.To_Bin_Location like '%DAMAGED%' then dt.BinQuantity else 0 end) As Qty_In_DamagedBin,
		   (Case when dt.To_Bin_Location like '%LOSS%' then dt.BinQuantity else 0 end) As Qty_In_LossBin,
		      (Case when dt.To_Bin_Location like '%DESTROYED%' then dt.BinQuantity else 0 end) As Qty_In_DestroyedBin,
		         (Case when dt.To_Bin_Location like '%TRANSIT%' then dt.BinQuantity else 0 end) As Qty_In_TransitBin,
	CASE
        WHEN dt.JournalRemarks like '%Inventory Transfer%'THEN 'Completed' 
        WHEN dt.JournalRemarks like  '%Cancel%' THEN 'Cancelled'
		WHEN dt.JournalRemarks is null THEN 'In Progress'
        ELSE 'Stock Transfers'         
    END AS 'Status'
	--dt.JournalRemarks
	--dt.Quantity as QuantitySent	

from  [reporting].[vSAPWH-DukaTransfers] as dt
where  CountryCode='KE' and dt.TRNSFRDATE like '%2023%'