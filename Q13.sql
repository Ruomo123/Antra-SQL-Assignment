-- 13.	List of stock item groups and total quantity purchased, total quantity sold, and the remaining stock quantity (quantity purchased ¨C quantity sold)
with cte1 as (
select	c.StockGroupID,
		sum(b.quantity) quant_sold
from Sales.Invoices a
left join Sales.InvoiceLines b
on a.InvoiceID = b.InvoiceID
left join  Warehouse.StockItemStockGroups c
on b.StockItemID = c.StockItemID 
group by c.StockGroupID
),

cte2 as (
select	c.StockGroupID,
		sum(b.OrderedOuters) quant_purchase
from Purchasing.PurchaseOrders a
left join purchasing.PurchaseOrderLines b
on a.PurchaseOrderID = b.PurchaseOrderID
left join  Warehouse.StockItemStockGroups c
on b.StockItemID = c.StockItemID 
group by c.StockGroupID
)
select cte1.StockGroupID, cte1.quant_sold, cte2.quant_purchase, (quant_purchase - quant_sold) quant_remain
from cte1 
inner join cte2 
on cte1.StockGroupID =  cte2.StockGroupID
order by StockGroupID;