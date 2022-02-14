-- Normalization
-- As we have a child, the height of the Patient can change, so height has to be removed to separate tabel,
-- the best idea is to remove it to Pacjenci.Visit and VisitDate move to Payment. 
-- In tabel Visit we gonna have columns: VisitsId, Weight and Height, 
-- BMI column will be removed
select * from Pacjenci.VisitParameters;

select p.Height, v.VisitID, v.weight, v.PatientID
into Pacjenci.VisitParameters 
from Pacjenci.Pacjenci as p
left outer join Pacjenci.Visit as v
	on p.PatientID = v.PatientId;

-- remove column Height from Pacjenci.Pacjenci
alter table Pacjenci.Pacjenci
drop column Height;
-- ad constraints to VisitParameters table PK and FK
alter table Pacjenci.VisitParameters
add VisitParametersID int identity(1,1) 
Constraint PK_VisitParametersID Primary key;
-- add constraint FK to PatinetID column
alter table Pacjenci.VisitParameters
add constraint FK_VisitParameters_PatientId
Foreign Key (PatientID) References Pacjenci.Pacjenci(PatientId);

select vp.VisitParametersID, p.PaymentId, p.DueDate, p.Ammount, p.PaymentStatus, p.VisitId
into Pacjenci.PaymentNew
from Pacjenci.VisitParameters as vp
left outer join Pacjenci.Payment as p
	on vp.VisitId = p.VisitId;

select * from Pacjenci.PaymentNew;
alter table Pacjenci.PaymentNew
add constraint PK_PaymentID
Primary key (PaymentID);

delete from Pacjenci.PaymentNew
where PaymentId is null;
-- Cannot define PRIMARY KEY constraint on nullable column in table 'PaymentNew'.
alter table Pacjenci.PaymentNew
alter column PaymentID int not null;

alter table Pacjenci.PaymentNew
add constraint Fk_VisitParameterdID_VisitParameterd
Foreign key (VisitParametersID) References Pacjenci.VisitParameters(VisitParametersID);
-- Now remove old tables Visit and Payment

alter table Pacjenci.Payment
drop constraint [PK_PacjenciPayment_PaymentId];
alter table Pacjenci.Payment
drop constraint [FK_Payment_To_Visit_On_VisitID];
 -- delete table Payment
drop table Pacjenci.Payment;
alter table Pacjenci.Visit
drop constraint [PK_PacjenciVisit_VisitId];
drop table Pacjenci.Visit;

alter table Pacjenci.VisitParameters
drop column VisitId;
alter table Pacjenci.PaymentNew
drop column VisitId;

select PatientId, PaymentId, height, weight, DueDate, Ammount, PaymentStatus
from Pacjenci.VisitParameters as vp
join Pacjenci.PaymentNew as p
	on vp.VisitParametersId=p.VisitParametersId;