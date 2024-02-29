select 
    OperationalYear,
	datefromparts(OperationalYear,1,1) as OperationalYearDate,
        RegionName,
	DimCountryId As CountryID,
        DimDistrictID,
	DistrictName,
        DimSiteID, 
        SectorName,
        SiteName,
	count(distinct globalclientid) as Clients,
	sum(case when NewMember = 1 then 1 else 0 end ) as NewClients,
	sum(case when NewMember = 0 then 1 else 0 end ) as ReturningClients,
	count(distinct DimSiteID) as Sites,
	count(Distinct DimGroupID) as Groups,
	sum(creditLocal) as InputCredit,
	cast(convert(varchar(10),min(CreatedDate) ,126 ) as date) as CreatedDate,
	sum(case when NewMember = 1 then creditlocal else 0 end) as NewMembersCredit,
	sum(case when NewMember = 0 then creditlocal else 0 end) as ReturningMembersCredit
from 
	v_clientsales 
where 
	 OperationalYear in (2021) and DimCountryID = 1
Group By
	OperationalYear,DimCountryID, RegionName, DimDistrictID, DistrictName, SectorName, DimSiteID, SiteName
