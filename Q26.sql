-- 26.	Revisit your answer in (19). Convert the result into an XML string and save it to the server using TSQL FOR XML PATH.
select	years as StockGroupName,
		[T-Shirts] TShirts,
		[USB Novelties] USBNovelties,
		[Packaging Materials] PackagingMaterials,
		[Clothing],
		[Novelty Items] NoveltyItems,
		[Furry Footwear] FurryFootwear,
		[Mugs],
		[Computing Novelties] ComputingNovelties,
		[Toys]
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
for XML PATH('Years'), ROOT('Order_Summary');