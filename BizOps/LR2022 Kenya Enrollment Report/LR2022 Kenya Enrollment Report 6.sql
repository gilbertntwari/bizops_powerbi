select 
    OperationalYear,
	DimCountryId As CountryID,
        RegionName,
        DimDistrictID,
	DistrictName,
        SectorName,
        SiteName,
        count(distinct globalclientid) as Clients,
        count(case when RepaymentLocal > 0 then 1 else 0 end ) as Starters,
        count(case when RepaymentLocal >= 0.10*creditLocal then 1 else 0 end) as QualifiedClients,
        sum(case when NewMember = 1 and RepaymentLocal >= 0.10*creditLocal then 1 else 0 end ) as QualifiedNewClients,
	sum(case when NewMember = 0 and RepaymentLocal >= 0.10*creditLocal then 1 else 0 end ) as QualifiedReturningClients,
        sum(creditLocal) as TotalCredit,
        sum(RepaymentLocal) as TotalRepaid,
        sum(case when NewMember = 1 and RepaymentLocal >= 0.10*creditLocal then creditlocal else 0 end) as NewMembersCredit,
	sum(case when NewMember = 0 and RepaymentLocal >= 0.10*creditLocal then creditlocal else 0 end) as ReturningMembersCredit,
        sum(case when RepaymentLocal >= 0.10*creditLocal then creditLocal else 0 end ) as QualifiedCreditAmount,
        sum(case when RepaymentLocal >= 0.10*creditLocal then RepaymentLocal else 0 end ) as QualifiedRepaidAmount
	
from 
	v_clientsales 
where 
	 OperationalYear in (2021) and DimCountryID = 1 and DroppedClient = 0
Group By
	OperationalYear,DimCountryID, RegionName,DimDistrictID, DistrictName, SectorName, SiteName
