-- 27.	Create a new table called ods.ConfirmedDeviveryJson with 3 columns (id, date, value) . Create a stored procedure,
-- input is a date. The logic would load invoice information (all columns) as well as invoice line information 
-- (all columns) and forge them into a JSON string and then insert into the new table just created. 
-- Then write a query to run the stored procedure for each DATE that customer id 1 got something delivered to him.
drop table if exists ods.ConfirmedDeviveryJson;
create table ods.ConfirmedDeviveryJson (
	id int,
	date datetime,
	value nvarchar(max)
)
alter table ods.ConfirmedDeviveryJson
	add constraint [value record should be formatted as JSON]
					check(isJSON(value)=1)

-- create the stored procedure that grab all invoice information, convert into JSON data, and insert into ods.ConfirmedDeviveryJson table
create proc InvoiceSummary @Date datetime
as
insert into ods.ConfirmedDeviveryJson(
	id,
	date,
	value
)
select *
from Sales.Invoices a
left join Sales.InvoiceLines b
on a.InvoiceID = b.InvoiceID
where a.InvoiceDate = @Date
for JSON auto;

-- use a cursor to reach each date that customer id 1 has a delivery on
declare @dates datetime;

declare cur cursor for
select InvoiceDate
from Sales.Invoices
where CustomerID=1;

open cur;
fetch next from cur
into @dates;

while @@fetch_status=0
begin
	exec InvoiceSummary @dates
	fetch next from cur
	into @dates
end

close cur;
deallocate cur;

select * from ods.ConfirmedDeviveryJson;