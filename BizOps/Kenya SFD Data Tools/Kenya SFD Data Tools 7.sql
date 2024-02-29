select CONCAT(DistrictName,SiteName) as  Uniqueid,DistrictName,SiteName, count(NewMember) AS Returning_Clients
from
v_clientSalesbizops
where Season ='2022, Long Rain' and CountryName='Kenya' and NewMember='0' and DistrictName<>'OAF Duka' and  DistrictName<>'KENYA STAFF'
group by DistrictName,SiteName

