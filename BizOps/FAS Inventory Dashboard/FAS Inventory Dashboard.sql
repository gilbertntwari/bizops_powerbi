--Getting good bins inventory status from SAP Warehouse 

--Selecting necessary columns for computation
select
	a.BaseType,
	a.Warehouse,
	a.bin,
	a.DukaName,
	a.ItemCode,
    a.ItemName,
	a.DocDate,
	(case when a.Bin='GOOD' then sum(a.Quantity) else 0 END) as GoodBins,
        (case when a.Bin='LOSS' then sum(a.Quantity) else 0 END) as LossBins,
	(case when a.Bin='DAMAGED' then sum(a.Quantity) else 0 END) as DamagedBins,
		(case when a.basetype=67 then sum(a.Quantity) else 0 END) as WHTransfer,
                (case when a.basetype=13 then sum(a.Quantity) else 0 END) as DukaSales,
				(case when a.basetype=10000071 or a.basetype=60 then sum(a.Quantity) else 0 END) as WrittenOff,

--logistics warehouses calculations
(case when a.Bin='GOOD' and warehouse !='Duka' then sum(a.Quantity) else 0 END) as WHGoodBins,
(case when a.Bin='GOOD' and warehouse not like '%Duka%' and Bin !='NULL' and BaseType=20 then sum(a.Quantity) else 0 END) as Supplier_WH_Good,
(case when a.Bin='GOOD' and warehouse not like '%Duka%' and Bin !='NULL' and BaseType=67 then sum(a.Quantity) else 0 END) as WHDukaDelivery,
(case when a.Bin='DAMAGED' and warehouse not like '%Duka%' and Bin !='NULL' and InventoryTransferType='Transfer In' then sum(a.Quantity) else 0 END) as WHGoodtoDamaged,
(case when a.Bin='LOSS' and warehouse not like '%Duka%' and Bin !='NULL' and InventoryTransferType='Transfer In' then sum(a.Quantity) else 0 END) as WHGoodtoLost,
(case when a.Bin='DAMAGED' and warehouse not like '%Duka%' and Bin !='NULL' then sum(a.Quantity) else 0 END) as WHDamagedBins,
(case when a.Bin='DAMAGED' and warehouse not like '%Duka%' and Bin !='NULL' and DocType='Goods Receipt PO' then sum(a.Quantity) else 0 END) as Supplier_WH_Dmgd

	         
from [OAF_SAP_DATAWAREHOUSE].[reporting].[v_MovementsAll_new] as a
where CountryName='Kenya' and Warehouse like 'Duka' and DukaName !='NULL' and Quantity >0 and a.ItemCode like '%COST%'
--Grouping selected data
Group by 	a.Bin,a.Warehouse,a.DukaName,a.ItemCode,a.ItemName,a.DocDate,a.basetype,a.InventoryTransferType,a.DocType