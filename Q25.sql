-- 25.	Revisit your answer in (19). Convert the result in JSON string and save it to the server using TSQL FOR JSON PATH.
select	*
from 
(
	select	d.StockGroupName,
			b.Quantity,
			year(a.OrderDate) years
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
) SourceTable
pivot
(sum(Quantity)
 for StockGroupName in (
		[T-Shirts],
		[USB Novelties],
		[Packaging Materials],
		[Clothing],
		[Novelty Items],
		[Furry Footwear],
		[Mugs],
		[Computing Novelties],
		[Toys]
		)) PivotTable
order by years
for JSON PATH, Root('order summary');
