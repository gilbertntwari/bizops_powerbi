Use [clientdatabase];


Select lead_id
from [reporting].[vPAYGOPS_Tupande_Sales]
Where LastStatusChangeDate > '2023-01-01'
and (input_name like '%Bean%' or input_name like '%Cabbage%' or input_name like '%Tomato%' or input_name like '%Sukuma%' or input_name like '%Spinach%'
	   or input_name like '%Carrot%' or input_name like '%Saga%' or input_name like '%Managu%' or input_name like '%Avoca%' or input_name like '%Brocolli%'
	    or input_name like '%Capsicum%' or input_name like '%pea%' or input_name like '%Cucumber%' or input_name like '%Green Gram%' or input_name like '%Beetroot%' or input_name like '%Skuma%'
	    or input_name like '%Parachichi%' or input_name like '%Maharage%' or input_name like '%Arachide%' or input_name like '%Macada%' or input_name like '%Japaneset%' or input_name like '%Prune_du_Japon%'
	    or input_name like '%Amabungo%' or input_name like '%Soja%' or input_name like '%G.nuts%' or input_name like '%Groundnuts%' or input_name like '%Maize mix plate%' or input_name like '%Gnut%'
	    or input_name like '%Soya%' or input_name like '%Orange Tree%' or input_name like '%Baka%' or input_name like '%Tom%' or input_name like '%Avoka%' or input_name like '%Gnuts%'
	    or input_name like '%SC 403%' or input_name like '%B-BIG 2245%' or input_name like '%KAR%' or input_name like '%B-Ipompo%' or input_name like '%SHU%' or input_name like '%POV%' or input_name like '%TUN%')
	    --and BundleName 

 Select ClientID from [reporting].[vERPLY_Tupande_Sales]
 Where Date > '2023-01-01' --and '2022-12-31'
and (InputName like '%Bean%' or InputName like '%Cabbage%' or InputName like '%Tomato%' or InputName like '%Sukuma%' or InputName like '%Spinach%'
	   or InputName like '%Carrot%' or InputName like '%Saga%' or InputName like '%Managu%' or InputName like '%Avoca%' or InputName like '%Brocolli%'
	    or InputName like '%Capsicum%' or InputName like '%pea%' or InputName like '%Cucumber%' or InputName like '%Green Gram%' or InputName like '%Beetroot%' or InputName like '%Skuma%'
	    or InputName like '%Parachichi%' or InputName like '%Maharage%' or InputName like '%Arachide%' or InputName like '%Macada%' or InputName like '%Japaneset%' or InputName like '%Prune_du_Japon%'
	    or InputName like '%Amabungo%' or InputName like '%Soja%' or InputName like '%G.nuts%' or InputName like '%Groundnuts%' or InputName like '%Maize mix plate%' or InputName like '%Gnut%'
	    or InputName like '%Soya%' or InputName like '%Orange Tree%' or InputName like '%Baka%' or InputName like '%Tom%' or InputName like '%Avoka%' or InputName like '%Gnuts%'
	    or InputName like '%SC 403%' or InputName like '%B-BIG 2245%' or InputName like '%KAR%' or InputName like '%B-Ipompo%' or InputName like '%SHU%' or InputName like '%POV%' or InputName like '%TUN%')
	    --and BundleName 














