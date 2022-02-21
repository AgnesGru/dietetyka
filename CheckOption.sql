-- check option prevent from adding to a table values below 100 and above 500
Create view Pacjenci.cena as select PaymentId, Ammount 
from Pacjenci.PaymentNew 
where Ammount between 100 and 500 with check option;

-- drop view Pacjenci.cena;