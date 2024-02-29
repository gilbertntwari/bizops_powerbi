IF OBJECT_ID('tempdb..#tempClientDeliveries') IS NOT NULL 
BEGIN 
    DROP TABLE #tempClientDeliveries
END;

IF OBJECT_ID('tempdb..#tempSeasonRetained') IS NOT NULL 
BEGIN 
    DROP TABLE #tempSeasonRetained
END;

select 
 OperationalYear, CreditCycleName, DimDistrictID, DistrictName, DimSiteID, SiteName, DimGroupId, GroupName, 
 GlobalClientID, Sum(TotalCredit) As TotalCredit, 
 DATEFROMPARTS(OperationalYear, 1, 1) As OperationalYearDate
into 
  #tempClientDeliveries
from 
	v_ClientBundles 
where 
	DimCountryID = 2 and OperationalYear > 2017 and BundleStatus = 'Delivered'  and DroppedClient = 0
Group By
	OperationalYear, CreditCycleName, DimDistrictID, DistrictName, DimSiteID, SiteName, DimGroupId, GroupName, GlobalClientID


select   
   #tempClientDeliveries.OperationalYear,OperationalYearDate, #tempClientDeliveries.DimDistrictId, #tempClientDeliveries.DimsiteId, #tempClientDeliveries.DimGroupId,    
   #tempClientDeliveries.GlobalClientID, y.CreditCycleName,   
   TotalCredit As CurrentYearCredit,  
      isnull(lead(#tempClientDeliveries.TotalCredit) over (partition by p.GlobalClientID order by y.operationalyear, y.CreditCycleName),0) as NextSeasonCredit,  
   isnull(lead(#tempClientDeliveries.CreditCycleName) over (partition by p.GlobalClientID order by y.operationalyear, y.CreditCycleName),0) as NextSeason,  
      case  
  When TotalCredit > 0 and isnull(lead(#tempClientDeliveries.TotalCredit) over (partition by p.GlobalClientID order by y.operationalyear, y.CreditCycleName),0) > 0 then 1  
  else 0   
   end as Retained  
into 
  #tempSeasonRetained
from   
 (select distinct operationalyear, CreditCycleName from #tempClientDeliveries ) y cross join  
     (select distinct GlobalClientID from #tempClientDeliveries) p left join  
     #tempClientDeliveries  
     on #tempClientDeliveries.OperationalYear = y.OperationalYear and #tempClientDeliveries.CreditCycleName = y.CreditCycleName  and #tempClientDeliveries.GlobalClientID = p.GlobalClientID  
where   
 #tempClientDeliveries.GlobalClientID is not null
order by
	#tempClientDeliveries.GlobalClientID,#tempClientDeliveries.OperationalYear, #tempClientDeliveries.CreditCycleName


select 
	OperationalYear, OperationalYearDate, DimDistrictId, DimSiteId, DimGroupId, CreditCycleName, NextSeason, sum(Retained) As RetainedClients
From
	#tempSeasonRetained
where 
	NextSeason <> '0'
Group by
	OperationalYear, OperationalYearDate, DimDistrictId, DimSiteId, DimGroupId, CreditCycleName, NextSeason
Order by
	OperationalYear,NextSeason
