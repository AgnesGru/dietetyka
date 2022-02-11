--  1 is not equal 0 True, but null is unknown ;) 
select p.FirstName, sum(pay.Ammount) razem
from Pacjenci.Pacjenci as p
left outer join Pacjenci.Visit as v
	on p.PatientID = v.PatientId
left outer join Pacjenci.Payment as pay
	on v.VisitId = pay.VisitId
where pay.PaymentStatus <> 0
group by p.FirstName;

-- Having is always after groupby 
-- what is avg pay for Patients who vivited me more than once. Who it was and how many visits
select p.firstName, count(v.VisitId) as visit_numbers, avg(pay.Ammount) avg_pay
from Pacjenci.Pacjenci as p
left outer join Pacjenci.Visit as v
	on p.PatientID = v.PatientId
left outer join Pacjenci.Payment as pay
	on v.VisitId = pay.VisitId
group by p.FirstName
having count(v.VisitId) > 1;

select * from Pacjenci.Payment;

select p.firstName, avg(pay.Ammount) avg_pay
from Pacjenci.Pacjenci as p
left outer join Pacjenci.Visit as v
	on p.PatientID = v.PatientId
left outer join Pacjenci.Payment as pay
	on v.VisitId = pay.VisitId
where ((pay.PaymentStatus <> 0 or pay.PaymentStatus is null)
and p.FirstName like 'A__')
group by p.FirstName
having avg(pay.Ammount) > 100;