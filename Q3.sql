-- 3.	List of customers to whom we made a sale prior to 2016 but no sale since 2016-01-01.
select	b.CustomerName,
		max(a.TransactionDate) latest_tran,
		min(a.TransactionDate) earliest_tran
from Sales.CustomerTransactions a
join Sales.Customers b
on a.CustomerID = b.CustomerID
group by b.CustomerName
having max(a.TransactionDate) < '20160101';