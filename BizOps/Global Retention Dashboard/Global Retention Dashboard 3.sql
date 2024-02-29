-- Banned Clients Previous Years
Select OperationalYear+1 as OperationalYear, CountryName, Concat(OperationalYear+1, CountryName) as UniqueID,
Count(DimClientID) AS Banned

From v_ClientBans where OperationalYear >= 2014 and CountryName in ('kenya','Rwanda','Burundi','Tanzania','Malawi','Nigeria')
Group by OperationalYear, CountryName 
Order by OperationalYear, CountryName ASC