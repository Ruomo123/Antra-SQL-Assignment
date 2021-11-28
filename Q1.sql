-- 1.	List of Persons¡¯ full name, all their fax and phone numbers, as well as the phone number and fax of the company they are working for (if any). 
-- (Look at customer table)
select a.FullName,
	a.PersonID,
	a.PhoneNumber person_phone_num,
	a.FaxNumber person_fax_num,
	b.PhoneNumber company_phone_num,
	b.FaxNumber company_fax_num
from Application.People a
left join Sales.Customers b
on b.PrimaryContactPersonID = a.PersonID or a.PersonId = b.AlternateContactPersonID;