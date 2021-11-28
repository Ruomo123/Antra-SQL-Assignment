-- 5.	List of stock items that have at least 10 characters in description.
select StockItemName, len(stockItemName) lengths
from Warehouse.StockItems
where len(StockItemName) >= 10;