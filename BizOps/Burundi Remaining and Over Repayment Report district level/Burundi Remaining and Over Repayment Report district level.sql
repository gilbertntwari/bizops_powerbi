
Select 
DistrictName, 
SiteName, 
GroupName, 
FirstName, 
LastName, 
AccountNumber, 
CreditLocal as TotalCredit, 
seasonname,
sum(CreditLocal) - sum(TotalRepaid_IncludingOverpayments)  as TotalOverpaid
from v_ClientSales
Where CountryName = 'Burundi'
and CreditLocal >= 0
Group by DistrictName, SiteName, GroupName, FirstName, LastName, AccountNumber,CreditLocal,SeasonName