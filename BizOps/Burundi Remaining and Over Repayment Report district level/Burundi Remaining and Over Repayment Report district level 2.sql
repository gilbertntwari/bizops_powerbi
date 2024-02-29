Select
DistrictName, 
SiteName, 
GroupName,
FirstName, 
LastName, 
AccountNumber,
seasonname, 
TotalRemaining,
sum(CreditLocal) as [total credit]
-- for overpaid remove the line below
-- How to calculate total overpaid
--TotalRepaid_IncludingOverpayments - CreditLocal as TotalOverpaid
from v_ClientSales
Where CountryName = 'Burundi'
-- For overpaid remove the line below
--and TotalRemaining >0
-- How to filter for overpayments
and CreditLocal >= 0
group by DistrictName, SiteName, GroupName,FirstName, LastName, AccountNumber,seasonname,TotalRemaining