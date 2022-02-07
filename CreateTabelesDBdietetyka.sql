select * from Pacjenci.Pacjenci
--
select * from Pacjenci.Illness
--
select * from Pacjenci.Visit

alter table Pacjenci.Pacjenci drop constraint UQ__Pacjenci__9DA40BC2F8300CB9;
alter table Pacjenci.Pacjenci drop column SocialSecurityNumber;

-- add two columns Data of Birth and Height to table Pacjenci
alter table Pacjenci.Pacjenci
	add DoB date not null;
alter table Pacjenci.Pacjenci
	add Height tinyint not null;

-- dodaj tabel� Illness
create table Pacjenci.Illness
	(IllnessId int not null identity(1,1),
	IllnessName varchar(30) not null,
	PatientId int not null);

-- zezw�l na warto�ci null w kolumnie PatientId w tabeli Illness
alter table Pacjenci.Illness drop column PatientId;
alter table Pacjenci.Illness
	add PatientId int;

-- dodaj tabel� Visit
create table Pacjenci.Visit
	(VisitId int not null identity(1,1),
	Weight tinyint not null,
	BMI decimal (5,2) not null,
	PatientId int not null);

-- dodaj kolumn� VisitDate
alter table Pacjenci.Visit
	add VisitDate date not null;

-- dodaj tabel� Payment
create table Pacjenci.Payment
	(PaymentId int not null identity(1,1),
	DueDate date not null,
	Ammount smallmoney not null,
	PaymentStatus bit not null,
	VisitId int not null);

-- dodawanie ogranicze�
alter table Pacjenci.Illness
	add constraint PK_PacjenciIllness_IllnessId
		Primary Key (IllnessId);
alter table Pacjenci.Payment
	add constraint PK_PacjenciPayment_PaymentId
		Primary Key (PaymentId);
alter table Pacjenci.Visit
	add constraint PK_PacjenciVisit_VisitId
		Primary Key (VisitId);

alter table Pacjenci.Illness
	add constraint UQ_PacjenciIllness_Illness_Name
	Unique (IllnessName);

--dodawanie kluczy obcych
alter table Pacjenci.Illness
	add constraint FK_Illness_To_Pacjenci_On_PatientID
		Foreign Key (PatientID)
			References Pacjenci.Pacjenci(PatientID);

-- usu� ograniczenie FK
ALTER TABLE Pacjenci.Visit DROP CONSTRAINT FK_Visit_To_Pacjenci_On_PatientID;

alter table Pacjenci.Visit
	add constraint FK_Visit_To_Pacjenci_On_PatientID
		Foreign Key (PatientID)
			References Pacjenci.Pacjenci(PatientID);

alter table Pacjenci.Payment
	add constraint FK_Payment_To_Visit_On_VisitID
		Foreign Key (VisitID)
			References Pacjenci.Visit(VisitID);