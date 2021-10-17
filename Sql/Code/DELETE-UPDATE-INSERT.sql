--CUSTOMER
INSERT INTO CUSTOMER (Passport_number,Customer_name,Customer_Phone,E_mail,Country,Adress)
VALUES
('1111117','Betül','5184765948','betul@gmail.com','Türkiye','1 sokak no 1'),
('1111118','Ayse','5289631578','Ayse@gmail.com','Ispanya','3 sokak no 9');

DELETE FROM CUSTOMER WHERE Customer_name='Hikmet';

Update CUSTOMER
SET Customer_name='Mustafa Hikmet'
WHERE Customer_name='Mustafa'


--COMPANY
INSERT INTO COMPANY (Company_name, Year_of_foundation)
VALUES
('FLY','2021');


Update COMPANY
SET Year_of_foundation='2022'
WHERE Year_of_foundation='2021'

DELETE FROM COMPANY Where Year_of_foundation>2021


--SEat_RESERVATÝON
INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-04-02','1','1111112',0,'Business',0);

UPDATE 	SEAT_RESERVATION
set Check_in = 1
WHERE Flight_number='AI111'
and Leg_number='1'
and Date='2021-04-02'
and Passport_number='1111112'

DELETE FROM SEAT_RESERVATION WHERE Check_in=0 and Date<GETDATE();



--FARES
INSERT INTO FARES (Flight_number, Amonuts,Restrictions)
VALUES
('IA111','400','Economy');

DELETE FROM FARES WHERE Amonuts<0 or Amonuts>100000;

UPDATE 	FARES
SET	Amonuts = Amonuts *1.2
WHERE Flight_number IN (SELECT FLIGHT.Flight_numberFROM FLIGHT WHERE Weekdays='Haftasonu')




--FLÝGHT_LEG
INSERT INTO FLIGHT_LEG (Flight_number,Departure_airport_code,Arrival_airport_code,Scheduled_departure_time,Scheduled_arrival_time,Milleage)
VALUES
('AB111','355','344','19:05','21:35','100');

DELETE FROM FLIGHT_LEG WHERE Milleage<101;
DELETE FROM FARES WHERE FARES.Flight_number='AB111'

UPDATE FLIGHT_LEG
SET Milleage=Milleage*1.120
WHERE Departure_airport_code IN(SELECT AIRPORT.Airport_CodeFROM AIRPORT WHERE AIRPORT.City='Tokyo')




--LEG_INSTANCE
INSERT INTO LEG_INSTANCE (Flight_number,Leg_number,Date,Number_of_available_seats,Airplane_id,Departure_airport_code,Arrival_airport_code,Departure_time,Arrival_time)
VALUES
('AI113','6','2021-04-25','114','21','343','066','07:00','13:00');

Update LEG_INSTANCE 
	SET Date='2021-01-20'
	Where Date='2021-04-25';

DELETE FROM LEG_INSTANCE WHERE DATE<GetDate()


