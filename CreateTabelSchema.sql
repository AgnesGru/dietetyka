-- create table
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