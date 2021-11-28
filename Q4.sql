-- 4.	List of Stock Items and total quantity for each stock item in Purchase Orders in Year 2013.
select b.StockItemID,
		sum(b.OrderedOuters) total_quant
from Purchasing.PurchaseOrders a
inner join Purchasing.PurchaseOrderLines b
on a.PurchaseOrderID=b.PurchaseOrderID
where year(a.OrderDate) = 2013
group by b.StockItemID;