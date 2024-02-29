SELECT Distinct DistrictName, DimSiteID, SiteName

FROM v_ClientInputs
where CountryName = 'Tanzania'
and OperationalYear = 2023
and DistrictName = @District
Order by DistrictName, SiteName asc 