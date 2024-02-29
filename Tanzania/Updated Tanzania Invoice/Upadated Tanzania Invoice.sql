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
		OperationalYear = 2021

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
	,InputName
	,Sum(CI.InputCredit) as InputCredit
	,CI.OperationalYear
    --,concat(DimInputID,BundleName,SelectionGroup) as UniqueID
	,SUM(Round(CI.InputCredit/1.19,-2)) as CalculatedInputCredit
	,SUM(Round(CI.InputCredit, -2)) - SUM(Round(CI.InputCredit/1.19,-2)) as CreditFee
	,CASE WHEN CI.InputName = 'PICS' THEN SUM(Round(CI.InputCredit/1.19,-2)) * 0.18  WHEN  InputName = 'Sun King Boom' THEN SUM(Round(CI.InputCredit/1.19,-2)) * 0.18 WHEN  CI.InputName = 'Mabati' THEN SUM(Round(CI.InputCredit/1.19,-2)) * 0.18
	WHEN CI. InputName = 'Kofia ya Mabati' THEN SUM(Round(CI.InputCredit/1.19,-2)) * 0.18 ELSE 0 END AS VAT 
	,Sum(CI.InputQuantity) as InputQuantity
	,CI.DimClientId
	,CI.AccountNumber
	,CD.PhoneNo

FROM v_ClientInputs AS CI


LEFT JOIN #CD AS CD ON
		CI.DimClientID=CD.ClientID
WHERE CI.CountryName = 'Tanzania'
and CI.OperationalYear = '2021'
and CI.DistrictName = @District
and CI.SiteName in (@Sites)
and CI.InputName in (@InputName)
and CI.InputName NOT IN('Dondoo za kuongeza kipato','Client Service Bundle','Delivery Fee','Funeral Insurance')
--and AccountNumber = 11875399

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
	,CI.InputName
	--,DimInputID
	,CI.OperationalYear
	--,InputQuantity
	,CI.DimClientId
	,CI.AccountNumber
	,CD.PhoneNo

	DROP TABLE #CD;