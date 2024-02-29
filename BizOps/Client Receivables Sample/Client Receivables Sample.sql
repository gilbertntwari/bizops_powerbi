WITH bundles as (
	select CountryName, DistrictName, GlobalClientID, LastName, FirstName,
		sum(case when CreatedDate < '20200301' then  TotalCredit else 0 end) as OpeningCredit,
		sum(case when CreatedDate >= '20200301' and  CreatedDate < '20200401' then  TotalCredit else 0 end) as ClosingCredit
	from v_ClientBundles
	where CreatedDate < '20200401'
	and CountryName = 'Malawi'
	group by CountryName, DistrictName, GlobalClientID, LastName, FirstName
),

-- one row for each user who made at least one repayment
repayment as (
	select CountryName, DistrictName, GlobalClientID, LastName, FirstName,
		
		-- opening and closing receipts sum across all repayment types(?)
		sum(case when CreatedDate < '20200301' then amount else 0 end) as OpeningReceipt,
		sum(case when CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as ClosingReceipts,
		
		
		-- this pivot might be done dynamically if you can execute a SELECT to get all the repayment types,
		-- and then construct a string of sql like this https://www.sqlservertutorial.net/sql-server-basics/sql-server-pivot/ to execute
		-- Simpler (though more fragile) is to hard code...
		sum(case when RepaymentTypeName = 'Auditor' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as Auditor,
		sum(case when RepaymentTypeName = 'Client Debt Forgiveness' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as ClientDebtForgiveness,
		sum(case when RepaymentTypeName = 'Crop Failure Compensation' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Crop Failure Compensation],
		sum(case when RepaymentTypeName = 'Deceased Debt Cancellation' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Deceased Debt Cancellation],
		sum(case when RepaymentTypeName = 'Discount' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as Discount,
		sum(case when RepaymentTypeName = 'Dropped Client Refund' and CreatedDate >= '20200301' and CreatedDate < '20200301' then amount else 0 end) as [Dropped Client Refund],
		sum(case when RepaymentTypeName = 'Early Repayment Bonus' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Early Repayment Bonus],
		sum(case when RepaymentTypeName = 'MobileMoney' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as MobileMoney,
		sum(case when RepaymentTypeName = 'Overpaid Refund' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Overpaid Refund],
		sum(case when RepaymentTypeName = 'Receipt' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as Receipt,
		sum(case when RepaymentTypeName = 'Repayment Write Off' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Repayment Write Off],
		sum(case when RepaymentTypeName = 'Spouse Deceased Debt Cancellation' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Spouse Deceased Debt Cancellation],
		sum(case when RepaymentTypeName = 'Transfer' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as Transfers,
		sum(case when RepaymentTypeName = 'Trial' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as Trial,
		sum(case when RepaymentTypeName = 'Voucher Receipt' and CreatedDate >= '20200301' and CreatedDate < '20200401' then amount else 0 end) as [Voucher Receipt]

		
		
		
		-- TODO: add other types. etc...

		
	from v_RepaymentConfidential
	where CreatedDate < '20200401'
	and CountryName = 'Malawi'
	group by CountryName, DistrictName, GlobalClientID, LastName, FirstName
)

select 
	-- Is there ever a case where a user appears in v_RepaymentConfidential but not in v_ClientBundles?  
	-- In case there is (?) coalesce here
	coalesce(bundles.CountryName, repayment.CountryName) as CountryName,
	coalesce(bundles.DistrictName, repayment.DistrictName) as DistrictName,
	coalesce(bundles.GlobalClientID, repayment.GlobalClientID) as GlobalClientID,
	coalesce(bundles.LastName, repayment.LastName) as LastName,
	coalesce(bundles.FirstName, repayment.FirstName) as FirstName,
	
	coalesce(bundles.OpeningCredit, 0) as OpeningCredit,
	coalesce(repayment.OpeningReceipt, 0) as OpeningReceipt,
	
	coalesce(bundles.OpeningCredit, 0) - coalesce(repayment.OpeningReceipt, 0) as OpeningBalanceAsOfStartdate,
	
	coalesce(repayment.Auditor, 0) as Auditor,
	coalesce(repayment.ClientDebtForgiveness, 0) as ClientDebtForgiveness,
	coalesce(repayment.[Crop Failure Compensation], 0) as [Crop Failure Compensation],
	coalesce(repayment.[Deceased Debt Cancellation], 0) as [Deceased Debt Cancellation],
	coalesce(repayment.Discount, 0) as Discount,
	coalesce(repayment.[Dropped Client Refund], 0) as [Dropped Client Refund],
	coalesce(repayment.[Early Repayment Bonus], 0) as [Early Repayment Bonus],
	coalesce(MobileMoney, 0) as MobileMoney,
	coalesce(repayment.[Overpaid Refund], 0) as [Overpaid Refund],
	coalesce(repayment.Receipt, 0) as Receipt,
	coalesce(repayment.[Repayment Write Off], 0) as [Repayment Write Off],
	coalesce(repayment.[Spouse Deceased Debt Cancellation], 0) as [Spouse Deceased Debt Cancellation],
	coalesce(repayment.Transfers, 0) as Transfers,
	coalesce(repayment.Trial, 0) as Trial,
	coalesce(repayment.[Voucher Receipt], 0) as [Voucher Receipt],

	-- TODO: add other repayment types...
	
	coalesce(bundles.ClosingCredit, 0) as ClosingCredit,
	coalesce(repayment.ClosingReceipts, 0) as ClosingReceipts
from bundles
	full outer join repayment on bundles.GlobalClientID = repayment.GlobalClientID