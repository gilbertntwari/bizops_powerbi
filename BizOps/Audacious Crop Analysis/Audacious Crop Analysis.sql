use RosterDataWarehouse;
select v_ClientBundles.GlobalClientID, 
v_ClientBundles.CountryName,
v_ClientBundles.SeasonName,
v_ClientBundles.BundleName, 
v_SeasonClientsInformation.ClientBirthYear,
v_SeasonClientsInformation.Gender,
case 
when  2021-v_SeasonClientsInformation.ClientBirthYear <= 35 THEN '16-35'
when 2021 - v_SeasonClientsInformation.ClientBirthYear <= 45 THEN '35-45' 
when 2021-v_SeasonClientsInformation.ClientBirthYear>45 then 'Above 45' ELSE 'Unknown age' End aS AgeBracket

from v_ClientBundles
inner join 
v_SeasonClientsInformation
on 
v_ClientBundles.GlobalClientID=v_SeasonClientsInformation.GlobalClientID

Where v_ClientBundles.OperationalYear>=2021
and BundleName in('TOM', 'Avoka', 'KAR', 'SHU', 'POV', 'Mac 44', 'BIG 2245', 'Capsicum', 'Beetroot', 'Carrot', 'Avocado Seedlings', 'Cowpea', 'Cabbage Proktor F1',
'Tomato Kilele F1', 'Cucumber', 'Saga', 'Spinach', 'Managu', 'Pigeon pea', 'Macadamia seedlings', 'Sukuma',
'Tomato Rambo F1', 'Cabbage Gloria F1', 'Avocat_Fruit_21B','Chaux_22A','Japanese_Plum_Fruit_21B','Macadamia_Fruit_21B','Mais 53_22A','Plants de Banane_22A',
'Pomme de terre_22A','Tomato seeds_10g_22A','Soja', 'Beans Lungwebungu Yellow','Beans Green (Lungwebungu)','Beans Green Lwangeni','Beans Lungwebungu Green FUD','Beans Lungwebungu Yellow','Beans Lungwebungu Yellow FUD',
'Beans Lwangeni Yellow','Beans Lwangeni Yellow FUD','Gnuts Wamusanga Green FUD','Gnuts Wamusanga Yellow FUD','Groundnuts Green (Lupande)','Groundnuts Green (MGV4)','Groundnuts Green (Wamusanga)','Groundnuts Yellow (Lupande)',
'Groundnuts Yellow (MGV4)','Groundnuts Yellow (Wamusanga)','Soya Green (Kafue)','Soya Green FUD','Soya Yellow (Kafue)','Soya Yellow FUD',
'Gnut Baka Cash','Gnut CG11 _Cash','Gnut CG11 _Loan','LR2022_Gnut Baka','LR2022_Gnut CG11','LR2022_Kidney Beans','Nua-45 Beans Cash','Nua-45 Beans Loan')