-- Eliminate duplicates Distinct
select * from Pacjenci.IllnessPatient;

-- OFFSET i  FETCH NEXT
select * from Pacjenci.Pacjenci
where FirstName like 'A%'
order by FirstName
offset 1 rows
fetch next 2 rows only;

--
