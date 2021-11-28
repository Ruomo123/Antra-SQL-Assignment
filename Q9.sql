-- 9.	List of StockItems that the company purchased more than sold in the year of 2015.
select aa.StockItemID, aa.total_sold,bb.total_purchase
from (
	select StockItemID,abs(sum(Quantity)) total_sold
	from Warehouse.StockItemTransactions
	where Quantity<0 and year(TransactionOccurredWhen)=2015
	group by StockItemID
) aa
full join (
	select StockItemID,abs(sum(Quantity)) total_purchase
	from Warehouse.StockItemTransactions
	where Quantity>0 and year(TransactionOccurredWhen)=2015
	group by StockItemID
) bb
on aa.StockItemID=bb.StockItemID
where aa.total_sold<bb.total_purchase
order by aa.StockItemID;
