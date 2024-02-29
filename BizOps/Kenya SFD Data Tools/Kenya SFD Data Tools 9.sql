SELECT    Season,
          DistrictName,
          SiteName, 
          Globalid,
          AccountNumber,	  
          NewMember, TotalCredit,Totalrepaid,
          count(distinct Globalid) as Clients,
 sum(case when TotalRepaid>=TotalCredit then 1 else 0 end ) as Completedloans

from
	 v_ClientSalesBizops
Where 
	  Season = '2022, Short Rain' and DimCountryID = 1
group by Season, DistrictName, SiteName, Globalid,AccountNumber, NewMember, TotalCredit,TotalRepaid