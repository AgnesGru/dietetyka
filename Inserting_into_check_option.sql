select * from Pacjenci.cena;

insert into Pacjenci.cena values ('', 600);
-- The attempted insert or update failed because the target view 
--either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION 
--and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
--The statement has been terminated.
insert into Pacjenci.cena values (1, 150);
--(1 row affected)