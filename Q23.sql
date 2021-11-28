-- 23.	Rewrite your stored procedure in (21). Now with a given date, it should wipe out all the order data prior to 
-- the input date and load the order data that was placed in the next 7 days following the input date.
create proc order_summary_seven_days @Date datetime
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
		--  wipe out all the order data prior to the input date
		delete from ods.Orders
		where  order_date < @Date
		-- load the order data that was placed in the next 7 days following the input date
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
		where a.OrderDate between @Date and dateadd(day,7,@Date)
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