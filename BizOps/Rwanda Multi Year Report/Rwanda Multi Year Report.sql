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
and OperationalYear >= 2017
and BundleName in ('SHS Phase 2 - 4 year','SHS Phase 2 - 3 year','SHS Phase 2 - 2 year','SHS 17A','SHS 18A','SHS 18A Late','SHS-18B','SHS-19B','19A SHS W_Discount','SHS-19A',
'19B SHS W_Discount','SHS-20A','20A SHS W_Discount','B-Biolite SHS','Biolite SHS','GL Agent Trial','GL Agent Trial 22A','Biolite_SHS_3','Biolite_SHS','B-SHS Ubudehe 2','B-Ipompo',
'B-SHS Ubudehe 3','B-Biolite-SHS','B-SHS Ubudehe 1')
and CreditPercentage < 1
and BundleQuantity > 0
order by SeasonName, DistrictName, SiteName ASC