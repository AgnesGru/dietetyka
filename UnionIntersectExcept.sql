-- Union
select FirstName from Pacjenci.Pacjenci
union
select IllnessName from Pacjenci.Illness
order by  1;

-- Union All does not eliminate duplicates
select FirstName from Pacjenci.Pacjenci
union all
select IllnessName from Pacjenci.Illness
order by  1;

select p.FirstName, max(pay.Ammount) as cena
from Pacjenci.PaymentNew as pay
join Pacjenci.Pacjenci as p
	on pay.PatientId = p.PatientID
where p.PatientId = 1
group by p.FirstName
Union
select p.FirstName, min(pay.Ammount)
from Pacjenci.PaymentNew as pay
join Pacjenci.Pacjenci as p
	on pay.PatientId = p.PatientID
where p.PatientId = 1
group by p.FirstName;

-- Intersect
select Ammount as cena
from Pacjenci.PaymentNew 
where PatientId = 1
Intersect
select Ammount
from Pacjenci.PaymentNew
where PatientId = 12;

-- Except -- this is asimetric
select Ammount as cena
from Pacjenci.PaymentNew 
where PatientId = 1
Except
select Ammount
from Pacjenci.PaymentNew
where PatientId = 12;