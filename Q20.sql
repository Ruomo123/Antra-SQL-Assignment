create function total_order(@order_id int)
returns int
as

begin
	declare @total int;
	select @total = sum(b.Quantity * b.UnitPrice)
	from Sales.Invoices a
	left join Sales.InvoiceLines b
	on a.InvoiceID = b.InvoiceID
	where a.OrderID = @order_id;
	return @total;
end;