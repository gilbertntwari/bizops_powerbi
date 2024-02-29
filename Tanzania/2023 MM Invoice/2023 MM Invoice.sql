Use RosterDataWarehouse;
IF OBJECT_ID('tempdb..#CD') IS NOT NULL
DROP TABLE #CD;

-- Create a table with summarized Repayment data at the client level from VR
CREATE TABLE #CD (
	-- Name and format the columns in the table
	ClientID int,
	PhoneNo int

)
-- Now add values into the table
INSERT INTO #CD (ClientID,PhoneNo)
SELECT DimClientID as ClientID, ClientPhoneNumber AS PhoneNo
	FROM v_SeasonClientsInformation
	WHERE 

		CountryName = 'Tanzania' AND
		OperationalYear = 2023

select 
Distinct CI.CountryName
	,CI.DistrictName
	,CI.DimSiteId
	,CI.SiteName
	,CI.GroupName
	,CI.FirstName
	,CI.LastName
	,CI.OAFID 
	,GlobalClientID
	,CI.BundleName
	,CI.BundleQuantity
	,CI.InputName
    ,CI.InputCredit AS InputCredit
	,CI.OperationalYear
    --,concat(DimInputID,BundleName,SelectionGroup) as UniqueID
	--,CI.InputCredit as CalculatedInputCredit
	,(InputCredit/1.09) * 0.09 AS CreditFee
,Case When CI.InputName in ('NPK-17', 'Yara Java', 'Urea', 'DAP') then 
	InputCredit - (Case when CI.InputName in ('NPK-17', 'Yara Java', 'Urea', 'DAP') THEN InputQuantity * 1400 when CI.InputName = 'CAN' THEN InputQuantity * 1200 Else 0 end) end as RuzukuCredit
,Case when CI.InputName = 'CAN' THEN CI.InputCredit - (CI.InputQuantity * 1200) Else 0 end as RuzukuCreditCAN

	,Case When CI.InputName in ('NPK-17', 'Yara Java', 'Urea', 'DAP', 'CAN') then (InputCredit/1.09) * 0.09 else 0 end as RuzukuCreditFee
,CASE WHEN InputName = 'PICS' THEN (InputCredit * 0.18) / 1.18  WHEN  InputName = 'Dawa ya fangasi Masterkinga' THEN (InputCredit * 0.18) / 1.18 WHEN  InputName = 'Turubai' THEN (InputCredit * 0.18) / 1.18  ELSE 0 END AS VAT 
	,Sum(CI.InputQuantity) as InputQuantity
	,CI.DimClientId
	,CI.AccountNumber
	,Case when CI.InputName in ('NPK-17', 'Yara Java', 'Urea', 'DAP') THEN InputQuantity * 1400 when CI.InputName = 'CAN' THEN InputQuantity * 1200 Else InputCredit End as [Bei ya Pembejeo kwa Mkuliam]
	,CD.PhoneNo
	

FROM v_ClientInputs AS CI


LEFT JOIN #CD AS CD ON
		CI.DimClientID=CD.ClientID
WHERE CI.CountryName = 'Tanzania'
and CI.OperationalYear = '2023'
and CI.DistrictName = @District
and CI.SiteName in (@Sites)
and CI.InputName in (@InputName)

AND CI.InputQuantity >0


Group by 
CI.CountryName
	,CI.DistrictName
	,CI.DimSiteId
	,CI.SiteName
	,CI.GroupName
	,CI.FirstName
	,CI.LastName
	,CI.OAFID 
	,CI.GlobalClientID
	,CI.BundleName
	,CI.BundleQuantity
	,CI.InputName
	--,DimInputID
	,CI.InputCredit
	,CI.OperationalYear
	,InputQuantity
	,CI.DimClientId
	,CI.AccountNumber
	,CD.PhoneNo


	Order by DistrictName, SiteName, GroupName asc
	DROP TABLE #CD;