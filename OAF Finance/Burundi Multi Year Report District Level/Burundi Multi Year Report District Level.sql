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
	Case when CreditPercentage = 0.5 then OperationalYear+1 WHEN CreditPercentage = 0.25 THEN OperationalYear+2 WHEN CreditPercentage = 0.166 THEN OperationalYear+3 
	WHEN CreditPercentage = 0.34 THEN OperationalYear+1 ELSE OperationalYear+4 END AS DueYear,
	CONCAT(SeasonName,GlobalClientID)  as UniqueID
from v_ClientBundles
where CountryName = 'Burundi'
and DistrictName = @District
and OperationalYear >= 2017
and BundleName in ('Sun King Home_60_23A', 'SKPro 300_23A', 'Phone_21B_2seasons', 'Ihema_23A', 'SK_Boom_22A', 'Pompe_22B', 
'SK_Boom_22B','SKP 300_21A_0.1', 'Phone22B','SKP+PICS gratuit','SKPro_21B','Telephone_Igitabo_22B','Sun King Home_60_22B',
'SKP 300_20B','SKP 300_21A','SKP II','M 5000_17A','SKH_40_22B','Biolite_620_23B','SKP 300_20A','SK Boom_23B','Ihema_23B',
'Pompe_22A','Telephone_Igitabo_22A','SKPro 300_22A','Telephone Itel 5615','SKP II_19B','SKH_Biolite_620','SKPro 300_23B',
'SKPro-300_22B','SKP+PICS rabais','SK Boom_23A')
and CreditPercentage < 1
and BundleQuantity > 0
order by SeasonName, DistrictName, SiteName ASC