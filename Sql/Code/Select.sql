USE [DB_AIRLINE]
GO
--Uçak þirketinin uçaklarýnýn isimleri
SELECT COMPANY.Company_name,AIRPLANE_TYPE.Type_name
FROM AIRPLANE_TYPE,COMPANY
WHERE AIRPLANE_TYPE.Company_id=COMPANY.Company_id
GROUP BY COMPANY.Company_name,AIRPLANE_TYPE.Type_name


--uçak tipi 777 olan uçak hangi þehirlere uçmaktadýr.
SELECT DISTINCT AIRPORT.City
FROM AIRPORT,CAN_LAND
WHERE CAN_LAND.Type_name='777'
AND CAN_LAND.Airport_code=AIRPORT.Airport_Code


--seat yapan yolcularýn isimleri,hangi saate rezervasyon yaptýklarý
SELECT s.Flight_number,s.Leg_number,s.Date,c.Customer_name
FROM CUSTOMER as c,SEAT_RESERVATION AS s
WHERE s.Passport_number=c.Passport_number
Group by s.Flight_number,s.Leg_number,s.Date,c.Customer_name

--Uçusun  hangi havayolu þireketi tarafýndan kaç paraya düzenlendiðini gösteren sorgu
Select AIRLINE.Airline_name,FLIGHT.Flight_number,Fares.Amonuts,Fares.Restrictions
From AIRLINE,FLIGHT, FARES
Where Fares.Flight_number=FLIGHT.Flight_number
and AIRLINE.Airline_id=FLIGHT.Airline_id


-- leg_intanceta satýla bilir koltyuk olan uçuþlarýn uçuþ numalarý hangi havalimanýndan ve hangi uçaktipi ile kalktýðýný gösteren sorgu
SELECT LEG_INSTANCE.Flight_number,AIRPORT.Name,AIRPLANE.Airplane_type
FROm AIRPORT ,LEG_INSTANCE, AIRPLANE
Where LEG_INSTANCE.Number_of_available_seats>3
and LEG_INSTANCE.Departure_airport_code=AIRPORT.Airport_Code 
and AIRPLANE.Airplane_id=LEG_INSTANCE.Airplane_id


--Hafta sonu ve busines olan uçuþlarýn uçuþ numaralarý, hangi þehre ve kaç para ile uçtuklarýný  gösteren sorgu
Select FARES.Flight_number, AIRPORT.Name,AIRPORT.City,FARES.Amonuts
from FARES ,FLIGHT_LEG,FLIGHT,AIRPORT
where FLIGHT_LEG.Flight_number IN (Select FLIGHT.Flight_number from FLIGHT where Weekdays='Haftasonu')
And FLIGHT_LEG.Flight_number=FLIGHT.Flight_number
And FLIGHT.Flight_number=FARES.Flight_number
And FLIGHT_LEG.Arrival_airport_code=AIRPORT.Airport_Code
and FARES.Restrictions='Business'





--Türk hava yollarý hangi sehirlere uçus yapmaktadýr.
Select DISTINCT AIRPORT.City
FROM AIRPORT,FLIGHT,AIRLINE,FLIGHT_LEG
WHERE AIRLINE.Airline_name='Türk Hava Yollarý'
And AIRLINE.Airline_id=FLIGHT.Airline_id
AND FLIGHT.Flight_number=FLIGHT_LEG.Flight_number
AND FLIGHT_LEG.Arrival_airport_code=AIRPORT.Airport_Code




--havayolu þirketlerinin hangi þehirlerden,hangi uçuþ numarasý ile ve hangi havalimanllarýndan kalktýðýný gösteren sorgu
SELECT ai.Airline_name,f.Flight_number,a.Name,a.City
FROM AIRLINE as ai,FLIGHT as f,FLIGHT_LEG as fl,AIRPORT as a
Where ai.Airline_id=f.Airline_id
and f.Flight_number=fl.Flight_number
and fl.Departure_airport_code=a.Airport_Code
group by ai.Airline_name,f.Flight_number,a.Name,a.City


--rezerve edilen uçuþlar hangi uçuþ þirketi tarafýndan düzenlenmektedýr ,hangi uçuþ ile uçmakta  ve uçan kiþiler kimlerdir.
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


--uçak kapasitesi 300 den fazla olan uçaklarýn hangi havayolu þirketi tarafýndan düzenlenen uçuþlarda uçmuþtur.
Select DISTINCT aýrt.Type_name,a.Airline_name
From AIRPLANE_TYPE as aýrt, CAN_LAND as can,AIRPORT as por,FLIGHT as f,FLIGHT_LEG as fl,AIRLINE as a
Where aýrt.Max_seat>300
and aýrt.Type_name = can.Type_name
and can.Airport_code=por.Airport_Code
and por.Airport_Code=fl.Arrival_airport_code
and fl.Flight_number=f.Flight_number
and f.Airline_id=a.Airline_id


--Bir uçuþ için tüm biletleri business olarak satan bir havayolu þirketi o uçuþtan toplam kaç para kazanýr.
Select  leg.Flight_number,leg.Date,SUM(fa.Amonuts*ap.Total_no_of_seat)
From FARES as fa,FLIGHT as f,FLIGHT_LEG as fl, LEG_INSTANCE as leg,AIRPLANE as ap
WHERE fa.Flight_number=f.Flight_number
and f.Flight_number=fl.Flight_number
and fl.Leg_number=leg.Leg_number
and leg.Airplane_id=ap.Airplane_id
and fa.Restrictions='Business'
GROUP BY leg.Leg_number,leg.Flight_number,leg.Date
ORDER BY SUM(fa.Amonuts*ap.Total_no_of_seat) asc



--Haftaiçi economy clasýnda dubaiye gitmek isteyen biri hangi þehirden kaç para ile gider.
Select Fares.Amonuts,AIRPORT.City
From FARES,FLIGHT_LEG  INNER JOIN AIRPORT ON AIRPORT.Airport_Code=FLIGHT_LEG.Departure_airport_code
WHERE FARES.Flight_number IN (Select FLIGHT.Flight_number from FLIGHT where Weekdays='Haftaiçi')
and FLIGHT_LEG.Flight_number=FARES.Flight_number
and FLIGHT_LEG.Arrival_airport_code IN (Select AIRPORT.Airport_Code  from AIRPORT where City='Dubai')
and FARES.Restrictions='economy';



--Left Outer join kullanýmý uçuþlarý olup amountlarý belli olmayan uçuþlarý görüntülemekteyiz.(LEFT OUTER JOÝN)
Select FLIGHT.Flight_number,Airline_id,Amonuts,Restrictions
From FLIGHT LEFT OUTER JOIN FARES
ON FLIGHT.Flight_number=FARES.Flight_number




--RIGHT OUTER JOIN kullanýmý seat reservation yapan customerlerin hangi customer hhangi seat_reservationlarý yaptýðý ve hangi customerlarýn seat_reservation yapmadýðýný göstermek için kullandým(RÝGHT OUTER JOÝN)
Select sr.Flight_number,sr.Leg_number,sr.Date,sr.Seat_number,cus.Customer_name
From SEAT_RESERVATION as sr RIGHT OUTER JOIN CUSTOMER as cus
ON sr.Passport_number=cus.Passport_number



--Full Outer join bir airline þirketi ayný zamanda airplane þirketi olamýyacaðý için Full outer join ile airline in airplane typede NULL airplane type airline de NULL deðerini çekiyor.(FULL OUTER JOÝN)
Select al.Airline_name,ap.Airplane_type
From AIRLINE as al FULL OUTER JOIN AIRPLANE as ap
ON al.Company_id=ap.Company_id


--uçuþ tarihi geçmiþ olan uçuþlarýn hangi havayolu þirketine baðlý olduðunu ve hangi uçuþ olduðunu gösteren sorgu(EXÝST)

Select AIRLINE.Airline_name
From AIRLINE 
Where  EXISTS(select * from FLIGHT as f,FLIGHT_LEG as fl,LEG_INSTANCE as leg Where GETDATE()>leg.Date 
		and leg.Leg_number=fl.Leg_number
		and leg.Flight_number=fl.Flight_number
		and fl.Flight_number=f.Flight_number
		and f.Airline_id=AIRLINE.Airline_id
		)



--Leg instancede uçuþu olmayan ve can_landý olamayan uçaklarýn id ve typelarý(NOT EXISTS)
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
		


--fiyatý 400 den yüksek olan uçuþlarýn nereye uçtuklarý
Select FLIGHT_LEG.Flight_number,FLIGHT_LEG.Leg_number,AIRPORT.Name
FROM AIRPORT,FLIGHT_LEG,FLIGHT
WHERE AIRPORT.Airport_Code=FLIGHT_LEG.Arrival_airport_code
and FLIGHT_LEG.Flight_number=FLIGHT.Flight_number
and FLIGHT.Flight_number IN(Select FARES.Flight_number From FARES Where FARES.Amonuts>'400')

--1000mill den fazla uçuþlar yapan uçuþ þirketlerinin isimleri
Select distinct AIRLINE.Airline_name
From AIRLINE,FLIGHT
Where AIRLINE.Airline_id=FLIGHT.Airline_id
and FLIGHT.Flight_number IN(Select FLIGHT_LEG.Flight_number FROm FLIGHT_LEG where FLIGHT_LEG.Milleage>'1000')

--%50sýn den fazla seat_reservetion yapýlmýþ olan uçuþlarýn hangi uçak ile seyahet ettiklerini ve hangi uçak þirketi tarafýndan yapýldýðýný gösteren sorgu
Select AIRPLANE.Airplane_type,COMPANY.Company_name
FROM AIRPLANE,COMPANY
WHERE AIRPLANE.Airplane_id IN(Select LEG_INSTANCE.Airplane_id FROM LEG_INSTANCE,AIRPLANE WHERE (AIRPLANE.Total_no_of_seat*0.5)<LEG_INSTANCE.Number_of_available_seats and LEG_INSTANCE.Airplane_id=AIRPLANE.Airplane_id)
and COMPANY.Company_id=AIRPLANE.Company_id

--busines ve economy toplam fiyatlarýnýn haftaiçi uçuþlarýn max fiyatlýya göre sýralanmasý
Select FARES.Flight_number,SUM(FARES.Amonuts)
FRom FARES 
WHERE FARES.Flight_number IN (Select FLIGHT.Flight_number FROM FLIGHT WHERE FLIGHT.Weekdays='Haftaiçi')
Group by FARES.Flight_number 
ORDER by SUM(FARES.Amonuts) desc

