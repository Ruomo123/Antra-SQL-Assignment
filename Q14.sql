-- 14.	List of Cities in the US and the stock item that the city got the most deliveries in 2016. 
-- If the city did not purchase any stock items in 2016, print ¡°No Sales¡±.
with cte as (
	select	c.CityName,
			d.StockItemID,
			case	when sum(d.Quantity) is not null then sum(d.Quantity) 
					else  'No Sales'
			end total_quant,
			row_number() over (partition by c.CityName order by sum(d.Quantity) desc ) row_num
	from Sales.Orders a
	left join Sales.Customers b
	on a.CustomerID=b.CustomerID
	left join Application.Cities c
	on b.PostalCityID = c.CityID
	left join Sales.OrderLines d
	on a.OrderID = d.OrderID
	where year(a.OrderDate)=2016 
	group by c.CityName, d.StockItemID
)
select CityName,StockItemID,total_quant from cte where row_num=1;