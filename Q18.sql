-- 18.	Create a view that shows the total quantity of stock items of each stock group sold (in orders) by year 2013-2017. 
-- [Stock Group Name, 2013, 2014, 2015, 2016, 2017]

select aa.StockGroupName, aa.quant_2013, bb.quant_2014, cc.quant_2015, dd.quant_2016, ee.quant_2017
from (
	select	d.StockGroupName,
			sum(b.Quantity) quant_2013
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
	where year(a.OrderDate)=2013
	group by d.StockGroupName
) aa
left join (
	select	d.StockGroupName,
			sum(b.Quantity) quant_2014
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
	where year(a.OrderDate)=2014
	group by d.StockGroupName
) bb
on aa.StockGroupName=bb.StockGroupName
left join (
	select	d.StockGroupName,
			sum(b.Quantity) quant_2015
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
	where year(a.OrderDate)=2015
	group by d.StockGroupName
) cc
on aa.StockGroupName=cc.StockGroupName
left join (
	select	d.StockGroupName,
			sum(b.Quantity) quant_2016
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
	where year(a.OrderDate)=2016
	group by d.StockGroupName
) dd
on aa.StockGroupName=dd.StockGroupName
left join (
	select	d.StockGroupName,
			sum(b.Quantity) quant_2017
	from Sales.Orders a
	left join Sales.OrderLines b
	on a.orderID=b.OrderID
	left join Warehouse.StockItemStockGroups c
	on b.StockItemID=c.StockItemID
	inner join warehouse.stockgroups d
	on c.StockGroupID = d.StockGroupID
	where year(a.OrderDate)=2017
	group by d.StockGroupName
) ee
on aa.StockGroupName=ee.StockGroupName;