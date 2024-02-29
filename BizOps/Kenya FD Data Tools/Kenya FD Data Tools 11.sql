select 
    OperationalYear,
	        RegionName,
  	        DistrictName,
                SiteName,
	         globalclientid,
	case when NewMember = 1 then 1 else 0 end as NewClients,
	case when NewMember = 0 then 1 else 0 end  as ReturningClients	
from 
	v_clientsales 
where 
OperationalYear ='2022' and CountryName='Kenya' and DroppedClient = 0 and NewMember='0' and DistrictName<>'OAF Duka' and  DistrictName<>'KENYA STAFF'


