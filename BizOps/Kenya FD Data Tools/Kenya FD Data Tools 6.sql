select CONCAT(DistrictName,SiteName) as  Uniqueid,DistrictName,SiteName, count(NewMember) AS Returning_Clients
from
v_clientSales
where OperationalYear ='2022' and CountryName='Kenya' and NewMember='0' and DistrictName<>'OAF Duka' and  DistrictName<>'KENYA STAFF'
group by DistrictName,SiteName

