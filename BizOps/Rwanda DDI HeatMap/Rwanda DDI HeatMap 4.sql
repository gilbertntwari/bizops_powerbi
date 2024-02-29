
Use RosterDataWarehouse;

IF OBJECT_ID('tempdb..#VR') IS NOT NULL
DROP TABLE #VR;


	CREATE TABLE #VR (

		ClientID int,
		Repayment int
	)

	INSERT INTO #VR (ClientID,Repayment)
	SELECT 
	DimClientID as ClientID, Max(Amount) AS Repayment
		FROM v_RepaymentBasic
		WHERE 
			CountryName = 'Rwanda' AND
			SeasonName = '2022'
			AND RepaymentTypeName = 'MobileMoney'
		GROUP BY DimClientID
	;


IF OBJECT_ID('tempdb..#TR') IS NOT NULL
DROP TABLE #TR;

CREATE TABLE #TR (
	-- Name and format the columns in the table
	ClientIDs int,
	Repayments int
)
-- Now add values into the table
INSERT INTO #TR (ClientIDs,Repayments)
SELECT OAFID as ClientIDs, Count(DimClientID) AS Repayments
		FROM v_RepaymentBasic
		WHERE 
			CountryName = 'Rwanda' AND
			SeasonName = '2022'
		GROUP BY OAFID
;

Select
SC.DistrictName,
	SC.SiteName,
	Concat(DistrictName, SiteName) AS UniqueID,
	Sum(Case when VR.Repayment - SC.TotalCredit >=0 THEN 1 ELSE 0 END) AS OnePaymentFinishers

	From v_ClientSalesBizOps as SC
		LEFT JOIN #VR AS VR ON
		SC.DimClientID=VR.ClientID	
		left JOIN #TR AS TR ON
	    SC.OAFID = TR.ClientIDs

	where SC.CountryName = 'Rwanda'
	and SC.OperationalYear = '2022'
	and SC.TotalCredit >0
	and TR.Repayments = 1
	AND VR.Repayment - SC.TotalCredit >=0

	Group by DistrictName, SiteName

	Drop Table #VR;
	Drop Table #TR