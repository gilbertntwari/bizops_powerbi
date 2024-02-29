select warehouse,
ItemCode As ProductCode,
ItemName As ProductName,
DocDate,
(case when Bin='GOOD' then sum(Quantity) else 0 END) as WHGoodBins,
(case when Bin='DAMAGED' then sum(Quantity) else 0 END) as WHDamagedBins,
(case when Bin='LOSS' then sum(Quantity) else 0 END) as WHLostBins,
(case when Bin='GOOD'  and BaseType=13 then sum(Quantity) else 0 END) as Supplier_WH_Good,
(case when Bin='GOOD' and BaseType=67 then sum(Quantity) else 0 END) as WHDukaDelivery,
(case when Bin='DAMAGED'  and InventoryTransferType='Transfer In' then sum(Quantity) else 0 END) as WHGoodtoDamaged,
(case when Bin='DESTROYED'  and InventoryTransferType='Transfer In' then sum(Quantity) else 0 END) as WHGoodtolost,
(case when Bin='DAMAGED'  and InventoryTransferType='Good RecievedPO' then sum(Quantity) else 0 END) as  Supplier_WH_Dmgd,
(case when Bin='LOSS'  and InventoryTransferType='Transfer In' then sum(Quantity) else 0 END) as WHDMGtolost,
(Case when Bin='GOOD' and Transtype=202 then sum(Quantity) else 0 END) as DMGDtoGoodBins,
(case when Bin='DAMAGED'  and InventoryTransferType='Bin In' then sum(Quantity) else 0 END) as  WH_DukaDmgd_WHDmgd,
(case when Bin='LOSS'  and InventoryTransferType='Bin In' then sum(Quantity) else 0 END) as  WH_DukaLoss_WHLoss,
(case when Bin='LOSS'  and InventoryTransferType='Transfer Out' then sum(Quantity) else 0 END) as  WH_LossWrittenOff



from  [OAF_SAP_DATAWAREHOUSE].[reporting].[v_MovementsAll_new]
where CountryCode='KE' and WarehouseType='Logistics'and warehouse !='Duka' and Quantity>0 and  warehouse not like 'Duka 0'
Group by Bin,warehouse, ItemCode,ItemName,DocDate,BaseType,InventoryTransferType,Transtype