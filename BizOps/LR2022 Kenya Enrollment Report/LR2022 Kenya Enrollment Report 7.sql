SELECT    
    OperationalYear, 
    RegionName,
    DistrictName,
    SectorName,
    SiteName,
    GlobalClientID,
    count(case when RepaymentLocal >= 500 then 1 else 0 end) as QualifiedClients	  
FROM            
    v_clientsales 
Where 
    OperationalYear = 2021 and DimCountryID = 1 and DroppedClient = 0
Group By 
  OperationalYear,RegionName,DistrictName,SectorName,SiteName,GlobalClientID