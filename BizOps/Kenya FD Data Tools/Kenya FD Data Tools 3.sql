Use RosterDataWarehouse;
select 
    OperationalYear,
	datefromparts(OperationalYear,1,1) as OperationalYearDate,
        RegionName,
	DimCountryId As CountryID,
        DimDistrictID,
	DistrictName,
        DimSiteID, 
        SiteName,
	count(distinct Globalid) as Clients,      
	sum(case when NewMember = 1 then 1 else 0 end ) as NewClients,
	sum(case when NewMember = 0 then 1 else 0 end ) as ReturningClients,
        count(case when TotalCredit> 0 then 1 else 0 end ) as Starters,
        sum(case when PercentRepaid < 1 then 1 else 0 end ) as LoansDue,
        sum(case when TotalRepaid>=TotalCredit then 1 else 0 end ) as Completedloans,
	count(distinct DimSiteID) as Sites,
	count(Distinct DimGroupID) as Groups,
	sum(TotalCredit) as InputCredit,
        sum(TotalRepaid) as TotalRepaid,
        sum(TotalRemaining) as RemainingCredit,
	cast(convert(varchar(10),min(DataEntry) ,126 ) as date) as CreatedDate,
	sum(case when NewMember = 1 then TotalCredit else 0 end) as NewMembersCredit,
	sum(case when NewMember = 0 then TotalCredit else 0 end) as ReturningMembersCredit
from 
	v_clientsalesBizops
where 
	 Season='2022, Long Rain' and DimCountryID = 1  and DistrictName not in ('KENYA STAFF', 'OAF Duka')
Group By
	OperationalYear,DimCountryID, RegionName, DimDistrictID, DistrictName, DimSiteID, SiteName
