insert into Pacjenci.Pacjenci(FirstName, LastName, Gender, DoB, Height)
values ('Aga', 'Gruszecka', 'K', '5/12/1981', 166);

-- wstaw dane do tabeli Pacjenci

select * from Pacjenci.Pacjenci;
insert into Pacjenci.Pacjenci(FirstName, LastName, Gender, DoB, Height)
values 
	('Paula', 'Gra', 'K', '2/12/1992', 180),
	('Barbra', 'Budka', 'K', '7/15/1983', 174),
	('Mateusz', 'Matematyk', 'M', '2/2/1979', 183),
	('Adam', 'Antek', 'M', '7/3/1991', 186),
	('Darek', 'TenDarek', 'M', '7/14/1991', 168),
	('Marcin', 'Gru', 'M', '2/14/1981', 186),
	('Fryderyk', 'Gru', 'M', '6/19/2012', 142),
	('Iwona', 'Brzoska', 'K', '4/10/1966', 174),
	('Andrzej', 'Mank', 'M', '1/16/1971', 178),
	('Anna', 'Konowa³ek', 'K', '7/7/1975', 176);

-- wstaw dane do tabeli Address

select * from Pacjenci.Address;
insert into Pacjenci.Address(Street, HomeNr, FlatNr, City,
							PostCode, Phone, District, PatientID)
values 
	('Lotnicza', '15', '', 'Cieplewo', '83-000', '661157746', 'pomorskie', 1);

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
	('Lotnicza', '15', null, 'Cieplewo', '81-745', '651227546', 'pomorskie', 13),
	('Szkolna', '45', null, 'Milejów', '80-020', '861127946', 'lubelskie', 14),
	('Podkomorzego', '15', '13', 'Lublin', '20-010', '641224746', 'lubelskie', 15),
	('Podkomorzego', '15', '13', 'Lublin', '20-010', '261223746', 'lubelskie', 16);

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
