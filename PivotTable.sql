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

-- now it is time to unpivot :))

-- first step
select FirstName, [January], [February]
into #TabUnpivot
From #Tab4Pivot
Pivot
(
count(PatientId) 
for month in ([January], [February])
) as p;
--second step
select Unpiv.FirstName, Unpiv.PatientId, Unpiv.month
From #TabUnpivot
Unpivot(
PatientId for month in ([January], [February])) as Unpiv
order by FirstName;

select *  from Pacjenci.Payment;
select *  from Pacjenci.Visit;

-- Let's find out who and how many Patients has PaymentStatus 0 which means that payment is late and 1 which means they paid on time.
select p.FirstName, pay.Ammount, pay.PaymentStatus
into #TabPiv5
from Pacjenci.Pacjenci as p
join Pacjenci.visit as v
	on p.PatientID = v.PatientId
join Pacjenci.Payment as pay
	on v.VisitId = pay.VisitId;

select FirstName, [1] as paid, [0] as delay
from #TabPiv5
Pivot (
sum(Ammount)
For PaymentStatus in ([1], [0])) as piv;

-- ok and now lets unpivot it again
Select FirstName, [1] as paid, [0] as delay
Into #Tab1Unpivot
From #TabPiv5
Pivot (
sum(Ammount)
For
PaymentStatus 
in ([1], [0])) as piv;

-- at the beginging I had 0 and 1 in column PaymentStatus but after unpivoting I have paid and delay
select Unpiv.FirstName, Unpiv.Ammount, Unpiv.PaymentStatus
From #Tab1Unpivot
Unpivot(
Ammount 
For PaymentStatus in ([paid], [delay])) as Unpiv;