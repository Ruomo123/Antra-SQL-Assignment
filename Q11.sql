-- 11.	List all the cities that were updated after 2015-01-01.
select *, CityID, CityName
from Application.Cities 
where ValidFrom > '20150101';