select 
ItemCode As ProductCode, 
ItemName As ProductName,
TRNSFRDATE,To_Bin_Location,From_Bin_Location,
        (case when  To_Bin_Location like '%Damaged%' then sum(Quantity) else 0 END) as DukaBin_DmgdBin,
  	(case when From_Bin_Location like '%Damaged%'  and To_Bin_Location like '%Good%' then sum(Quantity) else 0 END) as DMGD_GoodBin,
	(case when From_Bin_Location like '%Good%'  and To_Bin_Location like '%Damaged%' then sum(Quantity) else 0 END) as GdToDMGDBin

from [OAF_SAP_DATAWAREHOUSE].[reporting].[vSAPWH-DukaTransfers] as a  
where CountryCode='KE' and From_Warehouse='Duka' and TRNSFRDATE LIKE '%2023%'
Group by a.From_Bin_Location,a.To_Bin_Location,a.ITEMCODE,a.ITEMNAME,a.TRNSFRDATE

