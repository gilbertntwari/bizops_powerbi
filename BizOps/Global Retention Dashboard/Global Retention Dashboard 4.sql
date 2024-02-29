-- Returning Clients Qualified
Select OperationalYear, CountryName, Concat(OperationalYear, CountryName) as UniqueID,
Count(Distinct DimClientID) AS ReturnedQual


From v_ClientSales where OperationalYear >= 2015 and NewMember = 0 and ActiveClient = 1 and CountryName in ('kenya','Rwanda','Burundi','Tanzania','Malawi','Nigeria')
Group by OperationalYear, CountryName 
Order by OperationalYear, CountryName ASC