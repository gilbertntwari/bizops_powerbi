with groupInfo as
(
select 
	DistrictName, SectorName,DimSiteID, SiteName, GroupName,dimgroupid, 
	Sum(Case when PercentRepaid = 1 then 1 else 0 end) as Finishers,
	SUM(TotalRepaid) As TotalRepaid,
	SUM(TotalCredit) As TotalCredit,
	Count(DIMClientID) as SCI,
	CASE WHEN SUM(TotalCredit) - SUM(TotalRepaid) <= 100 THEN 1 Else 0  end AS GP
from
	v_ClientSalesBizOps
where
	CountryName = 'Nigeria'
	AND Season = '2022, Long Rain'

group by
	DistrictName, SectorName, DimSiteID, SiteName, GroupName,dimgroupid )
-- Second Inner Query
select 
	DistrictName, SectorName, SiteName,groupname,dimgroupid, 
	Sum(Finishers) as Finishers,
	SUM(TotalCredit) As TotalCredit,sum(TotalRepaid) As TotalRepaid,
    sum(GP) As CompletedGroupsCount,
	Count(GP) AS [Number of Groups],
	sum(SCI) as Clients,
Case when Sum(TotalRepaid) = 0 then 0 else SUM(TotalRepaid) / SUM(TotalCredit) end as [%Repaid]


From
	groupInfo
Group By
	DistrictName, SectorName, SiteName,groupname,dimgroupid
Order by
   DistrictName, SectorName, SiteName;