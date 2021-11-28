-- 12.	List all the Order Detail (Stock Item name, delivery address, delivery state, city, country, customer name, 
-- customer contact person name, customer phone, quantity) for the date of 2014-07-01. Info should be relevant to that date.
select	d.StockItemName,
		b.DeliveryInstructions delivery_address,
		g.StateProvinceCode delivery_state,
		f.CityName City,
		h.CountryName Country,
		e.CustomerName,
		i.FullName contact_person_name,
		e.PhoneNumber customer_phone,
		c.Quantity
from Sales.Orders a
left join Sales.Invoices b
on a.OrderID = b.OrderID
left join Sales.OrderLines c
on a.OrderID = c.OrderID
left join Warehouse.StockItems d
on c.StockItemID = d.StockItemID
left join Sales.Customers e
on a.CustomerID = e.CustomerID
left join Application.Cities f
on e.PostalCityID = f.CityID
left join Application.StateProvinces g
on f.StateProvinceID=g.StateProvinceID
left join Application.Countries h
on g.CountryID = h.CountryID 
left join Application.People i
on e.PrimaryContactPersonID = i.PersonID
where a.OrderDate = '20140701';