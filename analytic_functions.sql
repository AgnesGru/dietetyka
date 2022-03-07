select * from 
Pacjenci.Pacjenci as p
join Pacjenci.PaymentNew as pay
	on p.PatientID=pay.PatientId;

select top 5 p.FirstName, p.PatientID, pay.Ammount,
	sum(Ammount) over (Partition by p.PatientID) as payment
from Pacjenci.Pacjenci as p
join Pacjenci.PaymentNew as pay
	on p.PatientID=pay.PatientId
where pay.PaymentStatus != 0
order by payment desc;

-- Window


