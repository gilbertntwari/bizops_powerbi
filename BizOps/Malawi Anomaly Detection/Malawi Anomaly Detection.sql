with groupInfo as(
select 
	Season, DistrictName, DimDistrictID,SectorName, DimSectorID, DimSiteID, SiteName, GroupName, 
	Count(DIMClientID) as SCI,
	CASE WHEN Count(DimClientID) < 7 THEN 1 ELSE 0 END AS Less,
	Case When Count(DimClientID) > 25 THEN 1 Else 0  end AS More
from
	v_ClientSalesBizOps
where
	CountryName = 'Malawi'
	AND OperationalYear >=2023
	and DistrictName NOT IN ('Staff Input Access', 'Cooperatives ')
group by
	Season, DistrictName, DimDistrictID, SectorName, DimSectorID, DimSiteID, SiteName, GroupName  )
-- Second Inner Query
select 
	Season, DistrictName, SiteName, Concat(Season, DistrictName, SiteName) as UniqueID,
    sum(Less) As LessClients,
	Sum(More) AS MoreClients

From
	groupInfo
Group By
	Season, DistrictName, SiteName
Order by
   Season, DistrictName, SiteName