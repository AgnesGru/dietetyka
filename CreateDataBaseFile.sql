-- Skrypt s³u¿y do stworzenia bazy danych przy u¿yciu kodu T-SQL
Use master;
Create Database dietetyka1
on primary
(Name='dietetyka1', Filename = 'C:\SQLDATA\SBSTSQL1.mdf',
Size = 10MB, Maxsixe = 20, Filegrowth = 10%)
log on 
(Name='dietetyka1_log', Filename = 'C:\SQLLog\SBSTSQL1_log.ldf',
Size = 10MB, Maxsixe = 200, Filegrowth = 20%);