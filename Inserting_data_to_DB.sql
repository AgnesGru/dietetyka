insert into Pacjenci.Pacjenci(FirstName, LastName, Gender, DoB, Height)
--values ('Aga', 'Gruszecka', 'K', '5/12/1981', 166);

-- insert into Pacjenci table

select * from Pacjenci.Pacjenci;
insert into Pacjenci.Pacjenci(FirstName, LastName, Gender, DoB, Height)
values 
	--('Paula', 'Gra', 'K', '2/12/1992', 180),
	--('Barbra', 'Budka', 'K', '7/15/1983', 174),
	--('Mateusz', 'Matematyk', 'M', '2/2/1979', 183),
	--('Adam', 'Antek', 'M', '7/3/1991', 186),
	--('Darek', 'TenDarek', 'M', '7/14/1991', 168),
	--('Marcin', 'Gru', 'M', '2/14/1981', 186),
	--('Fryderyk', 'Gru', 'M', '6/19/2012', 142),
	--('Iwona', 'Brzoska', 'K', '4/10/1966', 174),
	--('Andrzej', 'Mank', 'M', '1/16/1971', 178),
	--('Anna', 'Konowa³ek', 'K', '7/7/1975', 176);

-- wstaw dane do tabeli Address

select * from Pacjenci.Address;
insert into Pacjenci.Address(Street, HomeNr, FlatNr, City,
							PostCode, Phone, District, PatientID)
values 
	--('Lotnicza', '15', '', 'Cieplewo', '83-000', '661157746', 'pomorskie', 1);

-- change FlatNr into null
update Pacjenci.Address
set FlatNr = null
where AddressID = 1;

insert into Pacjenci.Address(Street, HomeNr, FlatNr, City,
							PostCode, Phone, District, PatientID)
values 
	--('Jasna', '12', '3', 'Rumia', '84-230', '761229946', 'pomorskie', 8),
	--('Ciemna', '83', '23', 'Gdynia', '81-745', '567227446', 'pomorskie', 9),
	--('Dolna', '5', '59', 'Gdañsk', '81-745', '123227746', 'pomorskie', 10),
	--('Boczna', '2', '156', 'Gdañsk', '81-745', '661212346', 'pomorskie', 11),
	--('Lotnicza', '15', null, 'Cieplewo', '81-745', '561029746', 'pomorskie', 12),
	--('Lotnicza', '15', null, 'Cieplewo', '81-745', '651227546', 'pomorskie', 13),
	--('Szkolna', '45', null, 'Milejów', '80-020', '861127946', 'lubelskie', 14),
	--('Podkomorzego', '15', '13', 'Lublin', '20-010', '641224746', 'lubelskie', 15),
	--('Podkomorzego', '15', '13', 'Lublin', '20-010', '261223746', 'lubelskie', 16);

-- insert data into Pacjenci.Illness
insert into Pacjenci.Illness(IllnessName)
values 
	('Obesity'),
	('Allegy'),
	('Diabetes'),
	('Hypertension'),
	('Celiac disease'),
	('Atopic dermatitis');

select * from Pacjenci.Illness;

-- Unfortunately there has to be another table created. For many_to_many relation 
-- I need to add IllnessPatient table. I also need to drop PatientId column from 
-- Pacjenci.Illness table and remove FK_constraint.
ALTER TABLE Pacjenci.Illness   
DROP CONSTRAINT FK_Illness_To_Pacjenci_On_PatientID;

ALTER TABLE Pacjenci.Illness   
DROP COLUMN PatientId;

-- insert into IllnessPatient table
select * from Pacjenci.IllnessPatient;

insert into Pacjenci.IllnessPatient(PatientId, IllnessId)
values 
	--(15, 1),
	--(1, 2),
	--(14, 4),
	--(13, 5),
	--(7, 6);

-- wstawianie danych do tabeli Visit
select * from Pacjenci.Visit;
-- counting BMI values needs casting the type of the object
-- remove constraint not null from BMI column
alter table Pacjenci.Visit
alter column BMI decimal(5,2) null;

insert into Pacjenci.Visit(Weight, PatientID, VisitDate)
values 
	--(86, 12, Cast(GETDATE() as date)),
	--(39, 13, Cast(GETDATE() as date)), 
	--(80, 14, Cast(GETDATE() as date)),
	--(100, 15, Cast(GETDATE() as date)),
	--(60, 16, Cast(GETDATE() as date));

-- wyliczanie BMI

update Pacjenci.Visit
set BMI = cast(v.Weight as float)/(cast(p.Height as float)/100*cast(p.Height as float)/100)
from Pacjenci.Pacjenci as p
join Pacjenci.Visit as v
	on p.Patientid = v.PatientId
where weight is not null;

-- insert into Payment table
-- DueDate is VisitDate + 7 days
select * from Pacjenci.Payment;

alter table Pacjenci.Payment
alter column DueDate date null;

insert into Pacjenci.Payment(Ammount, PaymentStatus, VisitId)
values 
(150, 1, 2),
(150, 1, 3),
(200, 0, 4),
(100, 1, 5),
(150, 1, 6),
(200, 1, 7);

Update Pacjenci.Payment
set DueDate = Dateadd(day, 7, VisitDate) 
FROM Pacjenci.Visit as v
join Pacjenci.Payment as pay
	on v.VisitId=pay.VisitId;

select pay.DueDate, v.VisitDate
from Pacjenci.Visit as v
full outer join Pacjenci.Payment as pay
	on v.VisitId = pay.VisitId;