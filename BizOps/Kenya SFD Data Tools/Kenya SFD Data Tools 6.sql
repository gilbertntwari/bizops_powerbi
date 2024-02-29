select 
    OperationalYear,
	DimCountryId As CountryID,
        RegionName,
        DimDistrictID,
	DistrictName,
        SiteName,
        count(distinct globalclientid) as Clients,
        count(case when RepaymentLocal > 0 then 1 else 0 end ) as Starters,
        sum(case when PercentRepaid < 1 then 1 else 0 end ) as LoansDue,
        sum(case when PercentRepaid = 1 then 1 else 0 end ) as CompletedLoans,
        count(case when PercentRepaid >='0.1' then 1 else 0 end) as QualifiedClients,
        sum(case when NewMember = 1 and PercentRepaid >='0.1' then 1 else 0 end ) as QualifiedNewClients,
	sum(case when NewMember = 0 and PercentRepaid >='0.1'  then 1 else 0 end ) as QualifiedReturningClients,
        sum(creditLocal) as TotalCredit,
        sum(RepaymentLocal) as TotalRepaid,
        sum(case when NewMember = 1 and PercentRepaid >='0.1' then creditlocal else 0 end) as NewMembersCredit,
	sum(case when NewMember = 0 and PercentRepaid >='0.1' then creditlocal else 0 end) as ReturningMembersCredit,
        sum(case when PercentRepaid >='0.1' then creditLocal else 0 end ) as QualifiedCreditAmount,
        sum(case when PercentRepaid >='0.1' then RepaymentLocal else 0 end ) as QualifiedRepaidAmount
	
from 
	v_clientsales 
where 
	 SeasonName='2022, Long Rain' and DimCountryID = 1 and DroppedClient = 0 and PercentRepaid >='0.1'
Group By
	OperationalYear,DimCountryID, RegionName,DimDistrictID, DistrictName, SiteName
