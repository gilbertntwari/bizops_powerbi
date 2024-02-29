Use RosterDataWarehouse;

IF OBJECT_ID('tempdb..#WB') IS NOT NULL
DROP TABLE #WB;

	CREATE TABLE #WB (
		-- Name and format the columns in the table
		ClientID int,
		CreditSum int
	)
	-- Now add values into the table
	INSERT INTO #WB (ClientID,CreditSum)
	SELECT 
	DimClientID as ClientID, SUM(InputCredit) AS CreditSum
		FROM v_ClientInputs
		WHERE 
			CountryName = 'Malawi'
			and DistrictName= @District
			and OperationalYear = 2022
            and BundleName in ('G11982(Nanyati)', 'Nua 45') 
		GROUP BY DimClientID
	;


Select 
	SC.DistrictName
	,SC.SiteName
	,SC.GroupName
	,SC.DimClientID
	,SC.GlobalId
	,SC.FirstName
	,SC.LastName
	,SC.TotalCredit
	,SC.TotalRepaid
	,SC.TotalRemaining
	,SC.PercentRepaid	
    ,SC.AccountNumber
	,ISNULL(WB.CreditSum,0) as BeansCredit


FROM v_ClientSalesBizops AS SC
	LEFT JOIN #WB AS WB ON
		SC.DimClientID=WB.ClientID		



where SC.CountryName = 'Malawi'
and SC.OperationalYear = 2022
and WB.CreditSum > 0
and SC.DistrictName= @District
and TotalCredit >0
and WB.CreditSum > 0

DROP TABLE #WB;