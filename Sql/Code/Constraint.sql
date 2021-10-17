USE [DB_AIRLINE]
GO
--Flight leglerdeki milleage de�eri negatif bir de�er girilemez kontrol�n� yapt�ran constraint

Alter table FLIGHT_LEG
add constraint chc_Milleage
check(Milleage>0)

--LEG_INSTANCE Number_of_available_seats de�eri negatif de�er alamaz
Alter table LEG_INSTANCE
add constraint chc_ava_seat
check(Number_of_available_seats>0)

--AIRPLANE deki total seat alan� 0 den b�y�k olmal�
Alter table AIRPLANE
add constraint chc_Seat
check(AIRPLANE.Total_no_of_seat>0) 

--AIRPLANE_TYPE daki seat alan� 0 dan b�y�k olmal�
Alter table AIRPLANE_TYPE
add constraint chc_Seat_max
check(Max_seat>0) 

--flight_leg de arrival_airport_code ile departure_airport_code e�it olmamal�
Alter table FLIGHT_LEG
add constraint chc_arr_dep
check(Departure_airport_code!=Arrival_airport_code)

--flight_leg de arrival_airport_code ile departure_airport_code e�it olmamal�
Alter table LEG_INSTANCE 
add constraint chc_dep_arr
check(Departure_airport_code!=Arrival_airport_code)

--COMPANY tablosundaki name alan� unique olmal�
Alter table COMPANY 
add constraint chc_name
unique(Company_name) 

--Customer country alan�n� bo� b�rakt��� zaman T�rkiye olarak otomatik doldurmaktad�r.
Alter table Customer
add constraint chc_country
default ('T�rkiye') For Country