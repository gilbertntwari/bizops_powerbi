-- Returning Clients
Select OperationalYear, CountryName, Concat(OperationalYear, CountryName) as UniqueID,
Count(Distinct DimClientID) AS Returned


From v_ClientSales where OperationalYear >= 2015 and NewMember = 0 and DroppedClient = 0 and CountryName in ('kenya','Rwanda','Burundi','Tanzania','Malawi','Nigeria')
Group by OperationalYear, CountryName 
Order by OperationalYear, CountryName ASC