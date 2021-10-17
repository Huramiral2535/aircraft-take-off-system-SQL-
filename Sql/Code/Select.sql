USE [DB_AIRLINE]
GO
--U�ak �irketinin u�aklar�n�n isimleri
SELECT COMPANY.Company_name,AIRPLANE_TYPE.Type_name
FROM AIRPLANE_TYPE,COMPANY
WHERE AIRPLANE_TYPE.Company_id=COMPANY.Company_id
GROUP BY COMPANY.Company_name,AIRPLANE_TYPE.Type_name


--u�ak tipi 777 olan u�ak hangi �ehirlere u�maktad�r.
SELECT DISTINCT AIRPORT.City
FROM AIRPORT,CAN_LAND
WHERE CAN_LAND.Type_name='777'
AND CAN_LAND.Airport_code=AIRPORT.Airport_Code


--seat yapan yolcular�n isimleri,hangi saate rezervasyon yapt�klar�
SELECT s.Flight_number,s.Leg_number,s.Date,c.Customer_name
FROM CUSTOMER as c,SEAT_RESERVATION AS s
WHERE s.Passport_number=c.Passport_number
Group by s.Flight_number,s.Leg_number,s.Date,c.Customer_name

--U�usun  hangi havayolu �ireketi taraf�ndan ka� paraya d�zenlendi�ini g�steren sorgu
Select AIRLINE.Airline_name,FLIGHT.Flight_number,Fares.Amonuts,Fares.Restrictions
From AIRLINE,FLIGHT, FARES
Where Fares.Flight_number=FLIGHT.Flight_number
and AIRLINE.Airline_id=FLIGHT.Airline_id


-- leg_intanceta sat�la bilir koltyuk olan u�u�lar�n u�u� numalar� hangi havaliman�ndan ve hangi u�aktipi ile kalkt���n� g�steren sorgu
SELECT LEG_INSTANCE.Flight_number,AIRPORT.Name,AIRPLANE.Airplane_type
FROm AIRPORT ,LEG_INSTANCE, AIRPLANE
Where LEG_INSTANCE.Number_of_available_seats>3
and LEG_INSTANCE.Departure_airport_code=AIRPORT.Airport_Code 
and AIRPLANE.Airplane_id=LEG_INSTANCE.Airplane_id


--Hafta sonu ve busines olan u�u�lar�n u�u� numaralar�, hangi �ehre ve ka� para ile u�tuklar�n�  g�steren sorgu
Select FARES.Flight_number, AIRPORT.Name,AIRPORT.City,FARES.Amonuts
from FARES ,FLIGHT_LEG,FLIGHT,AIRPORT
where FLIGHT_LEG.Flight_number IN (Select FLIGHT.Flight_number from FLIGHT where Weekdays='Haftasonu')
And FLIGHT_LEG.Flight_number=FLIGHT.Flight_number
And FLIGHT.Flight_number=FARES.Flight_number
And FLIGHT_LEG.Arrival_airport_code=AIRPORT.Airport_Code
and FARES.Restrictions='Business'





--T�rk hava yollar� hangi sehirlere u�us yapmaktad�r.
Select DISTINCT AIRPORT.City
FROM AIRPORT,FLIGHT,AIRLINE,FLIGHT_LEG
WHERE AIRLINE.Airline_name='T�rk Hava Yollar�'
And AIRLINE.Airline_id=FLIGHT.Airline_id
AND FLIGHT.Flight_number=FLIGHT_LEG.Flight_number
AND FLIGHT_LEG.Arrival_airport_code=AIRPORT.Airport_Code




--havayolu �irketlerinin hangi �ehirlerden,hangi u�u� numaras� ile ve hangi havalimanllar�ndan kalkt���n� g�steren sorgu
SELECT ai.Airline_name,f.Flight_number,a.Name,a.City
FROM AIRLINE as ai,FLIGHT as f,FLIGHT_LEG as fl,AIRPORT as a
Where ai.Airline_id=f.Airline_id
and f.Flight_number=fl.Flight_number
and fl.Departure_airport_code=a.Airport_Code
group by ai.Airline_name,f.Flight_number,a.Name,a.City


--rezerve edilen u�u�lar hangi u�u� �irketi taraf�ndan d�zenlenmekted�r ,hangi u�u� ile u�makta  ve u�an ki�iler kimlerdir.
Select al.Airline_name,seat.Flight_number,cus.Customer_name
FROM AIRLINE as al, FLIGHT as f, FLIGHT_LEG as fl, LEG_INSTANCE as leg, SEAT_RESERVATION as seat,CUSTOMER as cus
WHERE al.Airline_id=f.Airline_id
and f.Flight_number=fl.Flight_number
and fl.Flight_number=leg.Flight_number
and fl.Leg_number=leg.Leg_number
and leg.Flight_number=seat.Flight_number
and leg.Leg_number=seat.Leg_number
and leg.Date=seat.Date
and seat.Passport_number=cus.Passport_number


--u�ak kapasitesi 300 den fazla olan u�aklar�n hangi havayolu �irketi taraf�ndan d�zenlenen u�u�larda u�mu�tur.
Select DISTINCT a�rt.Type_name,a.Airline_name
From AIRPLANE_TYPE as a�rt, CAN_LAND as can,AIRPORT as por,FLIGHT as f,FLIGHT_LEG as fl,AIRLINE as a
Where a�rt.Max_seat>300
and a�rt.Type_name = can.Type_name
and can.Airport_code=por.Airport_Code
and por.Airport_Code=fl.Arrival_airport_code
and fl.Flight_number=f.Flight_number
and f.Airline_id=a.Airline_id


--Bir u�u� i�in t�m biletleri business olarak satan bir havayolu �irketi o u�u�tan toplam ka� para kazan�r.
Select  leg.Flight_number,leg.Date,SUM(fa.Amonuts*ap.Total_no_of_seat)
From FARES as fa,FLIGHT as f,FLIGHT_LEG as fl, LEG_INSTANCE as leg,AIRPLANE as ap
WHERE fa.Flight_number=f.Flight_number
and f.Flight_number=fl.Flight_number
and fl.Leg_number=leg.Leg_number
and leg.Airplane_id=ap.Airplane_id
and fa.Restrictions='Business'
GROUP BY leg.Leg_number,leg.Flight_number,leg.Date
ORDER BY SUM(fa.Amonuts*ap.Total_no_of_seat) asc



--Haftai�i economy clas�nda dubaiye gitmek isteyen biri hangi �ehirden ka� para ile gider.
Select Fares.Amonuts,AIRPORT.City
From FARES,FLIGHT_LEG  INNER JOIN AIRPORT ON AIRPORT.Airport_Code=FLIGHT_LEG.Departure_airport_code
WHERE FARES.Flight_number IN (Select FLIGHT.Flight_number from FLIGHT where Weekdays='Haftai�i')
and FLIGHT_LEG.Flight_number=FARES.Flight_number
and FLIGHT_LEG.Arrival_airport_code IN (Select AIRPORT.Airport_Code  from AIRPORT where City='Dubai')
and FARES.Restrictions='economy';



--Left Outer join kullan�m� u�u�lar� olup amountlar� belli olmayan u�u�lar� g�r�nt�lemekteyiz.(LEFT OUTER JO�N)
Select FLIGHT.Flight_number,Airline_id,Amonuts,Restrictions
From FLIGHT LEFT OUTER JOIN FARES
ON FLIGHT.Flight_number=FARES.Flight_number




--RIGHT OUTER JOIN kullan�m� seat reservation yapan customerlerin hangi customer hhangi seat_reservationlar� yapt��� ve hangi customerlar�n seat_reservation yapmad���n� g�stermek i�in kulland�m(R�GHT OUTER JO�N)
Select sr.Flight_number,sr.Leg_number,sr.Date,sr.Seat_number,cus.Customer_name
From SEAT_RESERVATION as sr RIGHT OUTER JOIN CUSTOMER as cus
ON sr.Passport_number=cus.Passport_number



--Full Outer join bir airline �irketi ayn� zamanda airplane �irketi olam�yaca�� i�in Full outer join ile airline in airplane typede NULL airplane type airline de NULL de�erini �ekiyor.(FULL OUTER JO�N)
Select al.Airline_name,ap.Airplane_type
From AIRLINE as al FULL OUTER JOIN AIRPLANE as ap
ON al.Company_id=ap.Company_id


--u�u� tarihi ge�mi� olan u�u�lar�n hangi havayolu �irketine ba�l� oldu�unu ve hangi u�u� oldu�unu g�steren sorgu(EX�ST)

Select AIRLINE.Airline_name
From AIRLINE 
Where  EXISTS(select * from FLIGHT as f,FLIGHT_LEG as fl,LEG_INSTANCE as leg Where GETDATE()>leg.Date 
		and leg.Leg_number=fl.Leg_number
		and leg.Flight_number=fl.Flight_number
		and fl.Flight_number=f.Flight_number
		and f.Airline_id=AIRLINE.Airline_id
		)



--Leg instancede u�u�u olmayan ve can_land� olamayan u�aklar�n id ve typelar�(NOT EXISTS)
Select ap.Airplane_id,ap.Airplane_type
From AIRPLANE as ap
Where NOT EXISTS(
		select * 
		from LEG_INSTANCE as leg
		Where leg.Airplane_id=ap.Airplane_id)
	AND
		NOT EXISTS(
		select * 
		from AIRPLANE_TYPE as apt, CAN_LAND
		Where ap.Airplane_type=CAN_LAND.Type_name)
		


--fiyat� 400 den y�ksek olan u�u�lar�n nereye u�tuklar�
Select FLIGHT_LEG.Flight_number,FLIGHT_LEG.Leg_number,AIRPORT.Name
FROM AIRPORT,FLIGHT_LEG,FLIGHT
WHERE AIRPORT.Airport_Code=FLIGHT_LEG.Arrival_airport_code
and FLIGHT_LEG.Flight_number=FLIGHT.Flight_number
and FLIGHT.Flight_number IN(Select FARES.Flight_number From FARES Where FARES.Amonuts>'400')

--1000mill den fazla u�u�lar yapan u�u� �irketlerinin isimleri
Select distinct AIRLINE.Airline_name
From AIRLINE,FLIGHT
Where AIRLINE.Airline_id=FLIGHT.Airline_id
and FLIGHT.Flight_number IN(Select FLIGHT_LEG.Flight_number FROm FLIGHT_LEG where FLIGHT_LEG.Milleage>'1000')

--%50s�n den fazla seat_reservetion yap�lm�� olan u�u�lar�n hangi u�ak ile seyahet ettiklerini ve hangi u�ak �irketi taraf�ndan yap�ld���n� g�steren sorgu
Select AIRPLANE.Airplane_type,COMPANY.Company_name
FROM AIRPLANE,COMPANY
WHERE AIRPLANE.Airplane_id IN(Select LEG_INSTANCE.Airplane_id FROM LEG_INSTANCE,AIRPLANE WHERE (AIRPLANE.Total_no_of_seat*0.5)<LEG_INSTANCE.Number_of_available_seats and LEG_INSTANCE.Airplane_id=AIRPLANE.Airplane_id)
and COMPANY.Company_id=AIRPLANE.Company_id

--busines ve economy toplam fiyatlar�n�n haftai�i u�u�lar�n max fiyatl�ya g�re s�ralanmas�
Select FARES.Flight_number,SUM(FARES.Amonuts)
FRom FARES 
WHERE FARES.Flight_number IN (Select FLIGHT.Flight_number FROM FLIGHT WHERE FLIGHT.Weekdays='Haftai�i')
Group by FARES.Flight_number 
ORDER by SUM(FARES.Amonuts) desc

