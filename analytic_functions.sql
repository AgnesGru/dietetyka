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
--zwróæ wy³¹cznie wiersze z parzyst¹ wartoœci¹ kolumny Patiendid.
select p.FirstName, p.PatientID, pay.Ammount,
	sum(Ammount) over (Partition by p.PatientID) as payment
from Pacjenci.Pacjenci as p
join Pacjenci.PaymentNew as pay
	on p.PatientID=pay.PatientId
where p.PatientID % 2 = 0
order by payment desc;

-- sorting in analytic functins
select p.FirstName, p.PatientID, pay.Ammount, pay.PaymentId,
	sum(Ammount) over (Partition by p.PatientID) as payment,
	sum(Ammount) over (Partition by p.PatientID
	order by pay.PaymentId) as payment_increasing
from Pacjenci.Pacjenci as p
join Pacjenci.PaymentNew as pay
	on p.PatientID=pay.PatientId
order by payment;

-- named partitions??
-- window functions:Rows, Groups, Range
select p.FirstName, p.PatientID, pay.Ammount, pay.PaymentId,
	sum(Ammount) over (order by pay.Ammount
			Rows between 1 preceding and 1 following) as rolling_sum
from Pacjenci.Pacjenci as p
join Pacjenci.PaymentNew as pay
	on p.PatientID=pay.PatientId
order by pay.Ammount desc; --B£¥D!!!!!

--Groups


