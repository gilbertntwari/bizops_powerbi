select SectorName,SiteName,districtname,LastRepaymentDate,
count (GlobalId) as Clients,
count  (case  when percentrepaid  between 0 and 0.35 then 1 end) as [0 - 35%],
count  (case  when percentrepaid  between 0.36 and 0.49 then 1 end) as [36 - 49%],
count  (case  when percentrepaid  between 0.50 and 0.69 then 1 end) as [50 - 69%],
count  (case  when percentrepaid  between 0.70 and 0.99 then 1 end) as [70 - 99%],
Sum(Case when PercentRepaid = 1 then 1 else 0 end) as Finishers
from v_ClientSalesBizOps
where CountryName = 'nigeria' and season = '2022, long rain'
group by SectorName,SiteName,districtname,LastRepaymentDate