Select operationalyear,RegionName,DistrictName,bundlename, count (globalclientid) as totalclient

	from v_ClientBundles

	where operationalyear >= 2019  and BundleQuantity > 0
	and CountryName = 'kenya' and
	  (BundleName like '%Bean%' or BundleName like '%Cabbage%' or BundleName like '%Tomato%' or BundleName like '%Sukuma%' or BundleName like '%Spinach%'
	   or BundleName like '%Carrot%' or BundleName like '%Saga%' or BundleName like '%Managu%' or BundleName like '%Avoca%' or BundleName like '%Brocolli%'
	    or BundleName like '%Capsicum%' or BundleName like '%pea%' or BundleName like '%Cucumber%' or BundleName like '%Green Gram%' or BundleName like '%Beetroot%' or BundleName like '%Skuma%'
	    or BundleName like '%Parachichi%' or BundleName like '%Maharage%' or BundleName like '%Arachide%' or BundleName like '%Macada%' or BundleName like '%Japaneset%' or BundleName like '%Prune_du_Japon%'
	    or BundleName like '%Amabungo%' or BundleName like '%Soja%' or BundleName like '%G.nuts%' or BundleName like '%Groundnuts%' or BundleName like '%Maize mix plate%' or BundleName like '%Gnut%'
	    or BundleName like '%Soya%' or BundleName like '%Orange Tree%' or BundleName like '%SC Duma 43%' or BundleName like '%WH 505%' or BundleName like '%SC 513%' or BundleName like '%Punda Milia%'
	    or BundleName like '%SC Tempo 73%' or BundleName like '%PAN 691%' or BundleName like '%DK 777%' or BundleName like '%PAN 15%' or BundleName like '%DK 8031%' or BundleName like '%Monsanto%' or BundleName like '%SY594%'
		or BundleName like '%Pioneer%'or BundleName like '%Sungura%'or BundleName like '%H 6213%'or BundleName like '%H 614%'or BundleName like '%H 6218%'or BundleName like '%SC 403%'or BundleName like '%PN 15%'
		or BundleName like '%H 513%'or BundleName like '%SY594%'or BundleName like '%WH 509%'or BundleName like '%H 624%'or BundleName like '%DH 04%'or BundleName like '%WH 507%'or BundleName like '%POOL 9A%'or BundleName like '%H 1520%'
		or BundleName like '%ZM 607%'or BundleName like '%PAN 691%')
	    --and BundleName in  (@Bundles)
		Group by operationalyear,RegionName,DistrictName,BundleName
		--Order by CountryName ASC