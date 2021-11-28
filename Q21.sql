-- 21.	Create a new table called ods.Orders. Create a stored procedure, with proper error handling and transactions, 
-- that input is a date; when executed, it would find orders of that day, 
-- calculate order total, and save the information (order id, order date, order total, customer id) into the new table. 
-- If a given date is already existing in the new table, throw an error and roll back. Execute the stored procedure 5 times using different dates. 

/*drop schema if exists ods;
create schema ods;
*/

create proc order_summary @Date datetime
	as 
begin
drop table if exists ods.Orders ;
create table ods.Orders (
	order_id int,
	order_date datetime,
	order_total int,
	customer_id int
);

BEGIN TRY  
	begin transaction
		insert into ods.orders(
			order_id,
			order_date,
			order_total,
			customer_id
		)
		select	a.orderID, 
				a.OrderDate,
				sum(b.Quantity*b.UnitPrice) total_of_the_order
		from Sales.Orders a
		left join Sales.OrderLines b
		on a.OrderID = b.OrderID
		where a.OrderDate = @Date
		group by a.OrderDate,a.OrderID;
	commit transaction
END TRY  
BEGIN CATCH  
	if @@TRANCOUNT > 0
		 begin
			 PRINT ERROR_MESSAGE()
			 rollback transaction
	END
END CATCH
end