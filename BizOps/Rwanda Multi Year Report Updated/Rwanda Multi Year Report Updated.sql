Use RosterDataWarehouse;

Select 
CountryName,
	SeasonName, 
    DistrictName,
	SiteName,
	GroupName,
	GlobalClientID,
	CreditCycleName,
	BundleName,
	BundleQuantity,
	InputNames,
	InputCredit,
	FirstName,
	LastName,
	AccountNumber,
	CreditPercentage AS PercentageRepayment,
	Case when CreditPercentage = 0.5 then OperationalYear+1 WHEN CreditPercentage = 0.25 THEN OperationalYear+2 WHEN CreditPercentage = 0.166 THEN OperationalYear+3 ELSE OperationalYear+4 END AS DueYear,
	CONCAT(SeasonName,GlobalClientID)  as UniqueID
from v_ClientBundles
where CountryName = 'Rwanda'
and RegionName = @Region
and OperationalYear >= 2017
and BundleName in ('SHS 17A','SHS Phase 2 - 4 year','SHS Phase 2 - 3 year','SHS Phase 2 - 2 year','SHS 18A','SHS-18B','SHS 18A Late',
'SHS-19B','SHS-19A','19A SHS W_Discount','19B SHS W_Discount', '20A SHS W_Discount','SHS-20A','B-Biolite SHS','Biolite SHS', 'GL Agent Trial',
'B-SHS Ubudehe 1','B_Inkoko_Jun','B-SHS Ubudehe 3','B-SHS Ubudehe 2','Biolite_SHS','Biolite_SHS_3','GL Agent Trial 22A','B-Biolite-SHS',
'B-Biolite SHS 23B','Inkoko_Oct','Inkoko_Nov','SHS Ubudehe 2','SHS Ubudehe 3','Biolite-SHS','SHS Ubudehe 1','SHS Off Cycle_Sales')
and CreditPercentage IN (0,5,0.25,0.166,0.125)
and BundleQuantity > 0
order by SeasonName, DistrictName, SiteName ASC