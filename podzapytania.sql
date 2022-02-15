-- who pays me the highest per visit?
select * from Pacjenci.PaymentNew;

select p.FirstName, p.LastName, pay.Ammount 
from Pacjenci.Pacjenci as p
join Pacjenci.VisitParameters as v
	on p.PatientID=v.PatientID
join Pacjenci.PaymentNew as pay
	on v.VisitParametersID = pay.VisitParametersID
where pay.Ammount = 
(select max(Ammount) from Pacjenci.PaymentNew as pay);

-- who pays me the highest in total?
select top 1 sum(pay.Ammount) as in_total, p.FirstName, p.Lastname
from Pacjenci.PaymentNew as pay
join Pacjenci.VisitParameters as v
	on pay.VisitParametersID = v.VisitParametersID
join Pacjenci.Pacjenci as p
	on p.PatientID = v.PatientID
group by p.FirstName, p.Lastname
order by sum(pay.Ammount) desc;
--Who paid more than Iwona in total
select p.FirstName, p.LastName
from Pacjenci.Pacjenci as p
join Pacjenci.VisitParameters as v
	on p.PatientID=v.PatientID
join Pacjenci.PaymentNew as pay
	on v.VisitParametersID = pay.VisitParametersID
where pay.Ammount >
(select sum(pay.Ammount) 
from Pacjenci.Pacjenci as p
join Pacjenci.VisitParameters as v
	on p.PatientID=v.PatientID
join Pacjenci.PaymentNew as pay
	on v.VisitParametersID = pay.VisitParametersID
where p.FirstName = 'Iwona'
group by p.FirstName);
 
select * from Pacjenci.Pacjenci;