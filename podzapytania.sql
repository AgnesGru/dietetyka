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
 
select * from Pacjenci.VisitParameters;
select * from Pacjenci.PaymentNew;

-- raport with all invoices, patient id and global mean
SELECT v.PatientId , pay.Ammount,(SELECT AVG(Ammount) FROM Pacjenci.PaymentNew) AS avg_total_payment
FROM Pacjenci.VisitParameters as v
join Pacjenci.PaymentNew as pay
	on v.VisitParametersId = pay.VisitParametersId
ORDER BY v.PatientID desc;

--zestawienie ze œredni¹ faktur dla danego klienta
        
SELECT v.PatientID, AVG(Ammount) avg_payment
FROM Pacjenci.PaymentNew AS pay
join Pacjenci.VisitParameters as v
	on pay.VisitParametersID = v.VisitParametersID
where PatientID in (select PatientID from Pacjenci.VisitParameters group by PatientID)
group by v.PatientID;

SELECT v.PatientId ,pay.Ammount
	--(SELECT AVG(Ammount) FROM Pacjenci.PaymentNew AS pay
	--join Pacjenci.VisitParameters as v
	--on pay.VisitParametersID = v.VisitParametersID
	--where v.PatientID = 14) as avg_cust
	from  Pacjenci.PaymentNew AS pay
	join Pacjenci.VisitParameters as v
		on pay.VisitParametersID = v.VisitParametersID
	order by PatientID;

-- now it is time to addmit my DB was badly designed
-- What next: add FK for table PaymentNew conected to PatientID from table Pacjenci
-- remove PatientId column from VisitParameters table


