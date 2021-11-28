-- 8.	List of States and Avg dates for processing (confirmed delivery date ¨C order date) by month.
select	e.StateProvinceCode,
		cast(year(a.OrderDate) as varchar)  + '-' + cast(month(a.OrderDate) as varchar) months,
		avg(datediff(day, a.OrderDate, b.ConfirmedDeliveryTime)) process_date
from Sales.Orders a
inner join Sales.Invoices b
on a.OrderID=b.OrderID
left join Sales.Customers c
on a.CustomerID = c.CustomerID
left join Application.Cities d
on c.PostalCityID=d.CityID
left join Application.StateProvinces e
on d.StateProvinceID=e.StateProvinceID
group by e.StateProvinceCode, cast(year(a.OrderDate) as varchar)  + '-' + cast(month(a.OrderDate) as varchar)
order by e.StateProvinceCode, cast(year(a.OrderDate) as varchar)  + '-' + cast(month(a.OrderDate) as varchar);