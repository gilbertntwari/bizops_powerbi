SELECT [reporting].[vERPLY_Payments].Region, [reporting].[vERPLY_Payments].WarehouseName as Duka, 
	[reporting].[vERPLY_Payments].Date as ErplyDate,
	[reporting].[vERPLY_Payments].authorizationCode as ErplyMpesaCode, [reporting].[vERPLY_Payments].Sum ErplyAmount, 
	[clientdatabase].[reporting].[vMPESA_Payments].TransactionID, [clientdatabase].[reporting].[vMPESA_Payments].TransactionTime as MpesaDate,
	[clientdatabase].[reporting].[vMPESA_Payments].TransactionAmount as MpesaAmount,
	-- Mpesa Code Valid
	Case when len([reporting].[vERPLY_Payments].authorizationCode) = 10 then 'Valid' Else 'Invalid' End as [Mpesa Code Valid],
	-- Difference
	COALESCE([reporting].[vERPLY_Payments].Sum,0) - COALESCE([clientdatabase].[reporting].[vMPESA_Payments].TransactionAmount,0) as [Difference],
	-- Differences
	Case when COALESCE([reporting].[vERPLY_Payments].Sum,0) - COALESCE([clientdatabase].[reporting].[vMPESA_Payments].TransactionAmount,0) <0 then '[Mpesa>Erply]' 
	when COALESCE([reporting].[vERPLY_Payments].Sum,0) - COALESCE([clientdatabase].[reporting].[vMPESA_Payments].TransactionAmount,0) >0 then '[Erply>Mpesa]' Else 'NoDifference' end as Differences,
        -DATEDIFF(DAY,getdate(), [reporting].[vERPLY_Payments].Date) as Days,
        Case when [reporting].[vERPLY_Payments].authorizationCode = [clientdatabase].[reporting].[vMPESA_Payments].TransactionID then 1 else 0 end as CodeMatch


FROM [reporting].[vERPLY_Payments]
LEFT JOIN [clientdatabase].[reporting].[vMPESA_Payments]
ON [reporting].[vERPLY_Payments].authorizationCode = [clientdatabase].[reporting].[vMPESA_Payments].TransactionID
WHERE [reporting].[vERPLY_Payments].Date >='2023-01-01'
and COALESCE([reporting].[vERPLY_Payments].Sum,0) - COALESCE([clientdatabase].[reporting].[vMPESA_Payments].TransactionAmount,0) <> 0
Order by [reporting].[vERPLY_Payments].Region, [reporting].[vERPLY_Payments].WarehouseName, [reporting].[vERPLY_Payments].Date asc

