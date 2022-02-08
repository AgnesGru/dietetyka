-- create table Pacjenci
use dietetyka;
create table Pacjenci.Pacjenci
(
	PacjentID int Not Null Identity(1,1),
	FirstName varchar(50) Not Null,
	LastName varchar(50) Not Null
)
on DietetykaGr1; 

-- add new colum
use dietetyka;
alter table Pacjenci.Pacjenci
	add DateOfBirth char(11) not null unique;

alter table Pacjenci.Pacjenci drop constraint UQ__Pacjenci__9DA40BC2F8300CB9;
alter table Pacjenci.Pacjenci drop column SocialSecurityNumber;

-- add two columns Data of Birth and Height to table Pacjenci
alter table Pacjenci.Pacjenci
	add DoB date not null;
alter table Pacjenci.Pacjenci
	add Height tinyint not null;

-- dodaj tabelê Illness
create table Pacjenci.Illness
	(IllnessId int not null identity(1,1),
	IllnessName varchar(30) not null,
	PatientId int not null);

-- zezwól na wartoœci null w kolumnie PatientId w tabeli Illness
alter table Pacjenci.Illness drop column PatientId;
alter table Pacjenci.Illness
	add PatientId int;

-- dodaj tabelê Visit
create table Pacjenci.Visit
	(VisitId int not null identity(1,1),
	Weight tinyint not null,
	BMI decimal (5,2) not null,
	PatientId int not null);

-- dodaj kolumnê VisitDate
alter table Pacjenci.Visit
	add VisitDate date not null;

-- dodaj tabelê Payment
create table Pacjenci.Payment
	(PaymentId int not null identity(1,1),
	DueDate date not null,
	Ammount smallmoney not null,
	PaymentStatus bit not null,
	VisitId int not null);

-- dodawanie ograniczeñ
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

-- usuñ ograniczenie FK
ALTER TABLE Pacjenci.Visit DROP CONSTRAINT FK_Visit_To_Pacjenci_On_PatientID;

alter table Pacjenci.Visit
	add constraint FK_Visit_To_Pacjenci_On_PatientID
		Foreign Key (PatientID)
			References Pacjenci.Pacjenci(PatientID);

alter table Pacjenci.Payment
	add constraint FK_Payment_To_Visit_On_VisitID
		Foreign Key (VisitID)
			References Pacjenci.Visit(VisitID);

alter table Pacjenci.Payment
	add constraint DF_PacjenciPayment_PaymentStatus_True Default(1) for PaymentStatus;

-- TWORZENIE DIAGRAMÓW BD

-- add new table IllnessPatient for many_to_many relation between Illness and Pacjenci tables

create table Pacjenci.IllnessPatient
	(PatientId int not null,
	IllnessId int not null);

select * from Pacjenci.IllnessPatient
-- dodawanie constraints 

alter table Pacjenci.IllnessPatient
	add constraint FK_IllnessPatient_To_Pacjenci_On_PatientId
		Foreign Key (PatientId)
			References Pacjenci.Pacjenci(PatientID);

alter table Pacjenci.IllnessPatient
	add constraint FK_IllnessPatient_To_Illness_On_IllnessId
		Foreign Key (IllnessId)
			References Pacjenci.Illness(IllnessID);