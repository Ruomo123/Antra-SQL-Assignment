-- 2.	If the customer's primary contact person has the same phone number as the customer¡¯s phone number, list the customer companies. 
select CustomerName
from (
	select a.FullName,
		b.CustomerName,
		a.PersonID,
		a.PhoneNumber person_phone_num,
		a.FaxNumber person_fax_num,
		b.PhoneNumber company_phone_num,
		b.FaxNumber company_fax_num
	from Application.People a
	left join Sales.Customers b
	on b.PrimaryContactPersonID = a.PersonID
) aa
where aa.person_phone_num=aa.company_phone_num;