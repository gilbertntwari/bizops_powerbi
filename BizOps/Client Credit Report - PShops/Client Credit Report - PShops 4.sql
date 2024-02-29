Select 
BundleName
, BundleSignUpDate
,InputCredit
, Sum(InputQuantity) as BundleQuantity
,case when BundleName like '%cash%' then 'cash' else 'credit' end as CashCredit
From v_ClientInputs
  where
	DimDistrictID  in (100,234,285,286,287,313,314,315,316,319,320)
	and InputQuantity > 0
	Group by BundleName,InputCredit, BundleSignUpDate