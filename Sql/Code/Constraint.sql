USE [DB_AIRLINE]
GO
--Flight leglerdeki milleage deðeri negatif bir deðer girilemez kontrolünü yaptýran constraint

Alter table FLIGHT_LEG
add constraint chc_Milleage
check(Milleage>0)

--LEG_INSTANCE Number_of_available_seats deðeri negatif deðer alamaz
Alter table LEG_INSTANCE
add constraint chc_ava_seat
check(Number_of_available_seats>0)

--AIRPLANE deki total seat alaný 0 den büyük olmalý
Alter table AIRPLANE
add constraint chc_Seat
check(AIRPLANE.Total_no_of_seat>0) 

--AIRPLANE_TYPE daki seat alaný 0 dan büyük olmalý
Alter table AIRPLANE_TYPE
add constraint chc_Seat_max
check(Max_seat>0) 

--flight_leg de arrival_airport_code ile departure_airport_code eþit olmamalý
Alter table FLIGHT_LEG
add constraint chc_arr_dep
check(Departure_airport_code!=Arrival_airport_code)

--flight_leg de arrival_airport_code ile departure_airport_code eþit olmamalý
Alter table LEG_INSTANCE 
add constraint chc_dep_arr
check(Departure_airport_code!=Arrival_airport_code)

--COMPANY tablosundaki name alaný unique olmalý
Alter table COMPANY 
add constraint chc_name
unique(Company_name) 

--Customer country alanýný boþ býraktýðý zaman Türkiye olarak otomatik doldurmaktadýr.
Alter table Customer
add constraint chc_country
default ('Türkiye') For Country