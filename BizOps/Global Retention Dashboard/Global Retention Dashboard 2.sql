-- Total clients, Deceased previous year
Select OperationalYear+1 as OperationalYear, CountryName, Concat(OperationalYear+1, CountryName) as UniqueID,
Count(DimClientID) AS TotalEnrolled,
Count(Case When Deceased = 1 Then 1 End) As Deceased

From v_ClientSales where OperationalYear>= 2014 and CountryName in ('kenya','Rwanda','Burundi','Tanzania','Malawi','Nigeria')
Group by OperationalYear, CountryName 
Order by OperationalYear, CountryName ASC