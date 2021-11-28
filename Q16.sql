-- 16.	List all stock items that are manufactured in China. (Country of Manufacture)
select	distinct a.StockItemID,
		b.StockItemName
from [Warehouse].[StockItems] a
left join Warehouse.StockItems b
on a.StockItemID=b.StockItemID
where JSON_VALUE(a.CustomFields,'$.CountryOfManufacture') = 'China'
;
