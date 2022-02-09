-- this is an example query that shows how to use pivot tables
-- First step create temporary table
select p.FirstName, v.PatientId, datename(month, v.VisitDate) as month
into #Tab4Pivot
from Pacjenci.Pacjenci as p
right join Pacjenci.Visit as v
	on p.PatientID = v.PatientId
order by p.FirstName;

-- create pivoted table. Notice that squared brackets are necesary!!!
select 
	FirstName, [January], [February] 
from #Tab4Pivot
Pivot
(
count(PatientId) 
for month in ([January], [February])
) as p;