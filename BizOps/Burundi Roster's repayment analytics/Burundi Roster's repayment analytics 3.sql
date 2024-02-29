SELECT top 1000000000 DimDistrictID AS 'District ID'
,LastRepaymentDate as 'date', 
(DistrictName) AS 'District', 
(TotalCredit) AS 'Total credit', 
(TotalRepaid) AS 'Total repaid',SiteName 
FROM v_ClientSalesBizOps
WHERE GlobalId IS NOT NULL AND  CountryName = 'Burundi'
AND Season <> 'SEASON_DO_NOT_USE_FOMM_TRIAL' 
AND  TotalCredit>0 and season = '2023A' 