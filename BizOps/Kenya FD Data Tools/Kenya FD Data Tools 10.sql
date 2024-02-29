select 
    OperationalYear,
	        RegionName,
  	        DistrictName,
                SiteName,
	         globalclientid	
from 
	v_clientsales 
where 
OperationalYear ='2021' and CountryName='Kenya' and DroppedClient = '0'  and DistrictName<>'OAF Duka' and  DistrictName<>'KENYA STAFF'


