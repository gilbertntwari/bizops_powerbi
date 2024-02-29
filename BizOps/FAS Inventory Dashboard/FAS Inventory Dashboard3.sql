select ItemCode as ProductCode,ItemName as ProductName
from [OAF_SAP_DATAWAREHOUSE].[reporting].[v_MovementsAll_new]
where CountryName='Kenya' 
group by ItemCode,ItemName 