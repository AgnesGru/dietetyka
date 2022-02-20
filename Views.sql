--zestawienie ze œredni¹ faktur dla danego klienta
 
Create View Pacjenci.AvgPayment As
SELECT PatientID, AVG(Ammount) avg_payment
FROM Pacjenci.PaymentNew
where PatientID in (select PatientID from Pacjenci.PaymentNew group by PatientID)
group by PatientID;

