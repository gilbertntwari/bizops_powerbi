SELECT *
FROM v_ClientSales
WHERE CountryName = 'Tanzania'
and DistrictName = @District
and SeasonName = @Season
and DroppedClient = 1
ORDER BY SiteName, GroupName ASC