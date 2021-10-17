CREATE DATABASE DB_AIRLINE;

USE [DB_AIRLINE]
GO


CREATE TABLE AIRPORT(
	Airport_Code INT NOT NULL,
	Name VARCHAR(30) Unique,
	City VARCHAR(20),
	State VARCHAR(20),
	PRIMARY KEY(Airport_code)
	);

CREATE TABLE AIRPLANE_TYPE(
	Type_name VARCHAR(50) NOT NULL Unique,
	Max_seat INT,
	Company_id INT NOT NULL
	Primary KEY(Type_name));

Create table CAN_LAND(
	Airport_code int Not null,
	Type_name VARCHAR(50) Not null,
	Primary key(Airport_code,Type_name),
	Foreign key(Airport_code) REFERENCES AIRPORT(Airport_code),
	Foreign key(Type_name) REFERENCES AIRPLANE_TYPE(Type_name));

Create Table COMPANY(
	Company_id int Identity(1,1) Not null ,
	Company_name VARCHAR(30) Unique,
	Year_of_foundation int
	Primary key(Company_id));

Create Table AIRPLANE(
	Airplane_id int Not null,
	Total_no_of_seat int,
	Airplane_type VARCHAR(50) Not null,
	Company_id int Not null
	Primary key(Airplane_id)
	Foreign key(Airplane_type) REFERENCES AIRPLANE_TYPE(Type_name),
	Foreign key(Company_id) REFERENCES COMPANY(Company_id));

Create Table AIRLINE(
	Airline_id int not null Identity(1,1),
	Airline_name VARCHAR(30) Unique,
	Company_id int not null,
	Primary key(Airline_id),
	Foreign key(Company_id) REFERENCES COMPANY(Company_id));

Create Table FLIGHT(
	Flight_number VARCHAR(9) Not null,
	Airline_id int not null,
	Weekdays VARCHAR(20),
	Primary key(Flight_number),
	Foreign key(Airline_id) REFERENCES AIRLINE(Airline_id));

Create Table FARES(
	Flight_number VARCHAR(9) Not null,
	Fare_code BIT not null,
	Amonuts int,
	Restrictions Varchar(30),
	Primary key(Flight_number,Fare_code),
	Foreign key(Flight_number) REFERENCES FLIGHT(Flight_number));

Create Table FLIGHT_LEG(
	Flight_number VARCHAR(9) Not null,
	Leg_number int Identity(1,1) not null,
	Departure_airport_code int not null,
	Arrival_airport_code int not null,
	Scheduled_departure_time time,
	Scheduled_arrival_time time,
	Milleage float,
	Primary key(Flight_number,Leg_number),
	Foreign key(Flight_number) REFERENCES FLIGHT(Flight_number),
	Foreign key(Departure_airport_code) REFERENCES AIRPORT(Airport_Code),
	Foreign key(Arrival_airport_code) REFERENCES AIRPORT(Airport_Code));

Create table LEG_INSTANCE(
	Flight_number VARCHAR(9) Not null,
	Leg_number int  not null,
	Date Date not null,
	Number_of_available_seats int,
	Airplane_id int not null,
	Departure_airport_code int not null,
	Arrival_airport_code int not null,
	Departure_time time,
	Arrival_time time,
	Primary key(Flight_number,Leg_number,Date),
	Foreign key(Flight_number,Leg_number) REFERENCES FLIGHT_LEG(Flight_number,Leg_number),
	Foreign key(Departure_airport_code) REFERENCES AIRPORT(Airport_Code),
	Foreign key(Arrival_airport_code) REFERENCES AIRPORT(Airport_Code),
	Foreign key(Airplane_id) REFERENCES AIRPLANE(Airplane_id)
	);
Create Table CUSTOMER(
	Passport_number VARChar(7) not null,
	Customer_name VARCHAR(30),
	Customer_Phone decimal(10,0) Unique,
	E_mail Varchar(30) Unique,
	Country Varchar(20),
	Adress Varchar(60),
	Primary KEy(Passport_number));

Create Table SEAT_RESERVATION(
	Flight_number VARCHAR(9) Not null,
	Leg_number int not null,
	Date Date not null,
	Seat_number int not null,
	Passport_number VARChar(7) not null,
	Check_in BIT,
	Seat_type VarChar(10),
	Seat_Amount float null,
	Primary key(Flight_number,Leg_number,Date,Seat_number,Passport_number),
	Foreign key(Flight_number,Leg_number,Date) REFERENCES LEG_INSTANCE(Flight_number,Leg_number,Date),
	Foreign key(Passport_number) REFERENCES CUSTOMER(Passport_number)
	);

Create table FFC(
	Ffc_id int Identity(1,1) not null,
	Passport_number varchar(7) not null,
	Total_price float,
	Total_mil float,
	Times_Flew int,
	Mil_point float,
	Segment_point float,
	Segment_level varchar(10),
	Primary key(Passport_number,ffc_id),
	Foreign key(Passport_number) REFERENCES CUSTOMER(Passport_number)
	);

ALTER TABLE AIRPLANE_TYPE 
ADD Foreign key(Company_id) references COMPANY(Company_id);



