SELECT 
DistrictName,
SiteName,
GroupName,
FirstName,
LastName,
GlobalId,
TotalCredit,
TotalRepaid,

CASE WHEN DistrictName IN ('Dedza', 'Ntcheu') THEN 'Central Region' 
ELSE 'Malawi Southern'  END AS  RegionName,

CASE WHEN TotalRepaid > 0 THEN 1 ELSE 0  END AS Starters,

CASE 
 WHEN TotalCredit <=100000 AND TotalRepaid >=10000 THEN 1   
 WHEN TotalCredit >100000 AND TotalRepaid >=20000 THEN 1
 ELSE 0
END AS Qualifiers

FROM v_ClientSalesBizOps
WHERE CountryName = 'Malawi'
AND OperationalYear = 2023 
AND DistrictName <>'Staff Input Access';