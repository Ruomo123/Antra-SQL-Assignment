-- 6.	List of stock items that are not sold to the state of Alabama and Georgia in 2014.
-- create a CTE that grab the sate info, CustomerId and InvoiceID
with cte as (
	select	d.StateProvinceID,
			d.StateProvinceCode, 
			a.CustomerID,
			a.InvoiceID,
			a.TransactionDate
	from Sales.CustomerTransactions a
	left join Sales.Customers b
	on a.CustomerID=b.CustomerID
	left join Application.Cities c
	on b.PostalCityID=c.CityID
	left join Application.StateProvinces d
	on c.StateProvinceID=d.StateProvinceID
	where d.StateProvinceCode in ('AL','GA')
		and year(a.TransactionDate) =2014
		and d.CountryID=230
	)
-- use the CTE to join with InvoiceLines table to grab all the StockItemIDs that appear in AL and GA
-- then use StockItems table to filter out stockItemIDs that are in the joined table
select StockItemID
from WareHouse.StockItems 
where StockItemID not in (
select distinct b.StockItemID
from cte a
join Sales.InvoiceLines b
on a.InvoiceID = b.InvoiceID
);
