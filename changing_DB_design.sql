-- SEE ALSO PODZAPYTANIA.SQL
-- now it is time to addmit my db was badly designed
-- What next: add FK for table PaymentNew conected to PatientID from table Pacjenci
-- remove PatientId column from VisitParameters table

--select PatientID, VisitParametersID from Pacjenci.PaymentNew;

alter table Pacjenci.PaymentNew
add PatientId int;

Insert into Pacjenci.PaymentNew (PatientID)
Select PatientID
from Pacjenci.VisitParameters;

UPDATE Pacjenci.PaymentNew
    SET PatientID = (
        SELECT PatientID
        FROM Pacjenci.VisitParameters
        WHERE Pacjenci.PaymentNew.VisitParametersID = Pacjenci.VisitParameters.VisitParametersID);

ALTER TABLE Pacjenci.PaymentNew
ADD FOREIGN KEY (PatientId) REFERENCES Pacjenci.Pacjenci(PatientID);

alter table Pacjenci.VisitParameters
add PaymentId int;

ALTER TABLE Pacjenci.VisitParameters
ADD FOREIGN KEY (PaymentId) REFERENCES Pacjenci.PaymentNew(PaymentID);

select * from Pacjenci.VisitParameters;
select * from Pacjenci.PaymentNew;

alter table Pacjenci.VisitParameters
drop constraint [FK_VisitParameters_PatientId];

alter table Pacjenci.VisitParameters
drop column Patientid;

alter table Pacjenci.PaymentNew
drop constraint [Fk_VisitParameterdID_VisitParameterd];

alter table Pacjenci.PaymentNew
drop column VisitParametersID;