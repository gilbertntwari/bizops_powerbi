Select 
	TransactionTime
	, TransactionID
	, Concat(FirstName
	, ' '
	, MiddleName, LastName) as Name
	, TransactionAmount  
from [clientdatabase].[reporting].[vMPESA_Payments] 
WHERE TransactionTime >= '2023-01-01'
and TransactionTime  BETWEEN @StartDate AND @EndDate 