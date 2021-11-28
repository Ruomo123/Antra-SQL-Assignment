-- 15.	List any orders that had more than one delivery attempt (located in invoice table).
select OrderID
from Sales.Invoices
where JSON_VALUE(ReturnedDeliveryData, '$.Events[1].Status') is null;  
-- there are only two different values in "status" key : null and delivered. When null appears, 
-- there's always a comment stating "receiver not present," meaning there's more than one delivery attempt