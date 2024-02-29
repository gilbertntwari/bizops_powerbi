Use RosterDataWarehouse;
select Distinct BundleName, InputName, InputCredit
from v_ClientInputs
where DistrictName <> 'OAF Duka'
and SiteName <> 'Duka'
and InputQuantity > 0
and InputCredit > 0
and InputStatus = 'Un-delivered'
and OperationalYear > 2018