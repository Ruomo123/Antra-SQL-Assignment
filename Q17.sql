-- 17.	Total quantity of stock items sold in 2015, group by country of manufacturing.
select 
	JSON_VALUE(c.CustomFields,'$.CountryOfManufacture') country_of_manufacturing,
	sum(b.Quantity) total_quant_sold 
from Sales.Orders a
left join Sales.OrderLines b
on a.orderID=b.OrderID
left join Warehouse.StockItems c
on b.StockItemID = c.StockItemID
where year(a.OrderDate)=2015
group by JSON_VALUE(c.CustomFields,'$.CountryOfManufacture');