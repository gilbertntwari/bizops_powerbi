Use RosterDataWarehouse;
Select 
	VCB.CountryName, 
	Gender, 
	CASE 
		WHEN ClientBirthYear Is Null THEN Null
		WHEN year(GetDate()) - ClientBirthYear <= 35 THEN '16-35'
		WHEN year(GetDate()) - ClientBirthYear <= 45 THEN '35-45' 			
		ELSE 'Above 45' 
	End AS AgeBracket,
	Concat(VCB.CountryName, Gender, 
	CASE 
		WHEN ClientBirthYear Is Null THEN Null
		WHEN year(GetDate()) - ClientBirthYear <= 35 THEN '16-35'
		WHEN year(GetDate()) - ClientBirthYear <= 45 THEN '35-45' 			
		ELSE 'Above 45' end
	
	) as Uniquee,
	Count(VCB.GlobalClientID) As ClientCount
		
from 
		v_ClientBundles VCB left outer join v_SeasonClientsInformation VCSI on VCB.DimClientID = VCSI.DimClientID and VCB.OperationalYear = VCSI.OperationalYear
where 
		
          VCB.CountryName in (@Country) 
       and VCB.OperationalYear  >= 2021 and 
       VCSI.SeasonName in (@Season)  and
	  (BundleName like '%Bean%' or BundleName like '%Cabbage%' or BundleName like '%Tomato%' or BundleName like '%Sukuma%' or BundleName like '%Spinach%'
	   or BundleName like '%Carrot%' or BundleName like '%Saga%' or BundleName like '%Managu%' or BundleName like '%Avoca%' or BundleName like '%Brocolli%'
	    or BundleName like '%Capsicum%' or BundleName like '%pea%' or BundleName like '%Cucumber%' or BundleName like '%Green Gram%' or BundleName like '%Beetroot%' or BundleName like '%Skuma%' 
	    or BundleName like '%Parachichi%' or BundleName like '%Maharage%' or BundleName like '%Arachide%' or BundleName like '%Macada%' or BundleName like '%Japaneset%' or BundleName like '%Prune_du_Japon%' 
	    or BundleName like '%Amabungo%' or BundleName like '%Soja%' or BundleName like '%G.nuts%' or BundleName like '%Groundnuts%' or BundleName like '%Maize mix plate%' or BundleName like '%Gnut%'  
	    or BundleName like '%Soya%' or BundleName like '%Orange Tree%' or BundleName like '%Baka%' or BundleName like '%Tom%' or BundleName like '%Avoka%' or BundleName like '%Gnuts%'
	    or BundleName like '%SC 403%' or BundleName like '%B-BIG 2245%' or BundleName like '%KAR%' or BundleName like '%B-Ipompo%' or BundleName like '%SHU%' or BundleName like '%POV%' or BundleName like '%TUN%')
	    and BundleName in  (@Bundles)
Group By
	VCB.CountryName, 
	Gender, 
	CASE 
		WHEN ClientBirthYear Is Null THEN Null
		WHEN year(GetDate()) - ClientBirthYear <= 35 THEN '16-35'
		WHEN year(GetDate()) - ClientBirthYear <= 45 THEN '35-45' 			
		ELSE 'Above 45' 
	End