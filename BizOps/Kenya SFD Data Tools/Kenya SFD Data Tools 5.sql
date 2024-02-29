SELECT    OperationalYear, 
datefromparts(OperationalYear,1,1) as OperationalYearDate, 
DimCountryID, 
DimDistrictID, 	  
		  count(Distinct DimClientID) as Clients,
		  count(Distinct DimSiteID) as Sites,
		  count(Distinct DimGroupID) as Groups,
                              cast(convert(varchar(10),min(CreatedDate) ,126 ) as date) as CreatedDate,
		 Sum(CreditLocal) as InputCredit,
		  Sum(CreditLocal) as TotalCredit
FROM            
				v_clientsales 
Where 
		OperationalYear = 2022 and DimCountryID = 1 
Group By 
   OperationalYear, DimCountryID, DimDistrictID, CreatedDate
order by DimDistrictID, CreatedDate
