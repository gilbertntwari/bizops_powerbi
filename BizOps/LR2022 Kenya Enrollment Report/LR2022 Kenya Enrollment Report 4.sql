select 
    OperationalYear,
	datefromparts(OperationalYear,1,1) as OperationalYearDate,
	DimCountryId As CountryID,
        RegionName,
        DimDistrictID,
	DistrictName,
        SectorName,
        DimSiteID,
        SiteName,
	sum(case when NewMember = 1 and IsGroupLeader = 1 then 1 else 0 end ) as NewGLs,
	sum(case when NewMember = 0 and IsGroupLeader = 1 then 1 else 0 end ) as ReturningGLs,
        sum(case when NewMember = 1 and IsGroupLeader = 1 and RepaymentLocal >= 0.10*CreditLocal then 1 else 0 end ) as QualifiedNewGLs,
	sum(case when NewMember = 0 and IsGroupLeader = 1 and RepaymentLocal >= 0.10*CreditLocal then 1 else 0 end ) as QualifiedReturningGLs

from 
	v_clientsales 
where 
	 OperationalYear in (2021) and DimCountryID = 1 and DroppedClient = 0
Group By
	OperationalYear,DimCountryID,RegionName, DimDistrictID, DistrictName, SectorName,DimSiteID, SiteName
