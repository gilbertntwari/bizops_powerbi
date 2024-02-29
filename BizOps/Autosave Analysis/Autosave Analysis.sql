select CountryName, Autosaved, RepaidDate
from v_RepaymentBasic
WHERE CreatedDate >= '2021-01-01'
AND CountryName NOT IN ('Nigeria', 'Zambia')
and RepaymentTypeName = 'MobileMoney'