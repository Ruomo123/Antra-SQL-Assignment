-- 10.	List of Customers and their phone number, together with the primary contact person¡¯s name, 
-- to whom we did not sell more than 10  mugs (search by name) in the year 2016.
select	a.CustomerID, 
		a.CustomerName, 
		a.PhoneNumber,
		d.FullName Contact_Person_Name,
		abs(sum(b.quantity)) total_quant
from Sales.Customers a
left join Warehouse.StockItemTransactions b
on a.CustomerID = b.CustomerID
left join Warehouse.StockItemStockGroups c
on b.StockItemID = c.StockItemID
left join Application.People d
on a.PrimaryContactPersonID = d.PersonID
where	c.StockGroupID = 3
	and b.Quantity<0
	and year(b.TransactionOccurredWhen) = 2016
group by a.CustomerID, 
		 a.CustomerName, 
		 a.PhoneNumber,
		 d.FullName
having abs(sum(b.quantity)) <=10
order by abs(sum(b.quantity));