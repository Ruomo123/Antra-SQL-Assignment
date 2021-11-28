-- 19.	Create a view that shows the total quantity of stock items of each stock group sold (in orders) by year 2013-2017. 
-- [Year, Stock Group Name1, Stock Group Name2, Stock Group Name3, бн , Stock Group Name10] 
create view Q19 as
select	  years as StockGroupName,
		*
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
order by years;
