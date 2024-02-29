Use RosterDataWarehouse;

--First Query
with groupInfo as(
select 
	DistrictName, SectorName, SiteName, GroupName, 
	SUM(TotalRepaid) As TotalRepaid,
	SUM(TotalCredit) As TotalCredit,
	Count(DIMClientID) as Farmers,
	Sum(Case when PercentRepaid = 1 then 1 end) as Finishers,
	Count(Distinct DimGroupID) AS grps,
	CASE WHEN SUM(TotalCredit) - SUM(TotalRepaid) = 0 THEN 1 Else 0  end AS GP
from
	v_ClientSalesBizOps
where
	CountryName = 'Nigeria'
	AND Season = @Season
	and TotalCredit > 0

group by
	DistrictName, SectorName, SiteName, GroupName  )
-- Second Inner Query
select 
	DistrictName, SectorName, SiteName, 
	SUM(TotalCredit) As TotalCredit,sum(TotalRepaid) As Repaid,
    sum(GP) As CompletedGroupsCount,
	Count(GP) AS TGP,
	Sum(Farmers) as Farmers,
	Sum(Finishers) as Finishers,
                   Sum(grps) as grps
From
	groupInfo
Group By
	DistrictName, SectorName, SiteName
Order by
   DistrictName, SectorName, SiteName