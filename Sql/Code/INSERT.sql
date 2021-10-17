USE [DB_AIRLINE]
GO

INSERT INTO COMPANY (Company_name, Year_of_foundation)
VALUES
('Türk Hava Yollarý','1933'),
('Boeing','1916'),
('Pegasus','1990'),
('SunExpress','1989'),
('Airbus','1970'),
('Anadolu jet','1993');

INSERT INTO AIRPORT (Airport_Code, Name,City,State)
VALUES
('355','Adnan Menderes Havalimaný','izmir','Acik'),
('344','Sabiha Gökçen Havalimaný','istanbul','Acik'),
('568','Dubai Uluslararasý Havalimaný','Dubai','Acik'),
('533','Tokyo Haneda Havalimaný','Tokyo','Acik'),
('343','Ýstanbul Havalimaný','istanbul','Acik'),
('066','Ankara Esenboða Havalimaný','Ankara','Acik'),
('116','Yeniþehir Havalimaný','Bursa','Acik'),
('465','LaGuardia Havalimaný','NewYork','Acik');


INSERT INTO AIRPLANE_TYPE (Type_name, Max_seat,Company_id)
VALUES 
('787','270','2'),
('777','400','2'),
('777X','430','2'),
('737','170','2'),
('A380','300','5'),
('A300','200','5'),
('A321','210','5'),
('787X','300','2'),
('A350','350','5');

INSERT INTO AIRPLANE VALUES('16','280','787X','2');
INSERT INTO AIRPLANE VALUES('25','335','A350','5');
INSERT INTO AIRPLANE VALUES('11','250','787','2');
INSERT INTO AIRPLANE VALUES('12','380','777','2');
INSERT INTO AIRPLANE VALUES('13','380','777','2');
INSERT INTO AIRPLANE VALUES('14','380','777','2');
INSERT INTO AIRPLANE VALUES('21','285','A380','5');
INSERT INTO AIRPLANE VALUES('22','285','A380','5');
INSERT INTO AIRPLANE VALUES('23','285','A380','5');
INSERT INTO AIRPLANE VALUES('15','150','737','2');
INSERT INTO AIRPLANE VALUES('24','200','A321','5');

INSERT INTO AIRLINE (Airline_name, Company_id)
VALUES
('Türk Hava Yollarý','1'),
('SunExpress Hava Yollarý','3'),
('Pegasus Hava Yollarý','4'),
('Anadolu Jet hava yollarý','2');



INSERT INTO CAN_LAND (Airport_code, Type_name)
VALUES
('355','787'),
('355','777'),
('355','777X'),
('344','A380'),
('344','787'),
('344','777'),
('344','A321'),
('343','787'),
('343','777'),
('343','737'),
('343','A380'),
('533','777'),
('533','777X'),
('568','777'),
('568','777X'),
('066','777'),
('066','737'),
('066','787'),
('066','A380'),
('066','A321');


INSERT INTO FLIGHT (Flight_number, Airline_id, Weekdays)
VALUES
('AI111','1','Haftaiçi'),
('AI112','2','Haftaiçi'),
('AI113','3','Haftaiçi'),
('AI114','1','Haftasonu'),
('DT111','1','Haftaiçi'),
('TD111','1','Haftaiçi'),
('DT112','1','Haftasonu'),
('IA111','2','Haftaiçi'),
('BA111','1','Haftaiçi'),
('AB111','2','Haftaiçi');




INSERT INTO FLIGHT_LEG VALUES('AI111','355','344','19:05','21:35','350');
INSERT INTO FLIGHT_LEG VALUES('IA111','344','355','22:05','00:35','350');
INSERT INTO FLIGHT_LEG VALUES('DT112','533','568','19:00','05:55','1350');
INSERT INTO FLIGHT_LEG VALUES('TD111','568','533','08:00','15:55','1350');
INSERT INTO FLIGHT_LEG VALUES('AI114','344','066','16:40','20:50','600');
INSERT INTO FLIGHT_LEG VALUES('AI113','343','066','07:00','13:00','590');
INSERT INTO FLIGHT_LEG VALUES('DT111','344','568','11:00','23:55','2000');


INSERT INTO LEG_INSTANCE VALUES('AI111','1','2021-02-02','800','11','355','344','19:05','21:35');
INSERT INTO LEG_INSTANCE VALUES('IA111','2','2021-02-15','900','12','344','355','22:05','00:35');
INSERT INTO LEG_INSTANCE VALUES('DT112','3','2021-02-05','110','11','533','568','19:00','05:55');
INSERT INTO LEG_INSTANCE VALUES('TD111','4','2021-03-18','111','13','568','533','08:00','15:55');
INSERT INTO LEG_INSTANCE VALUES('AI114','5','2021-02-21','115','14','344','066','16:40','20:50');
INSERT INTO LEG_INSTANCE VALUES('AI113','6','2021-04-25','114','21','343','066','07:00','13:00');
INSERT INTO LEG_INSTANCE VALUES('AI111','1','2021-04-02','800','11','355','344','19:05','21:35');
INSERT INTO LEG_INSTANCE VALUES('DT112','3','2021-03-05','110','11','533','568','19:00','05:55');


INSERT INTO CUSTOMER (Passport_number,Customer_name,Customer_Phone,E_mail,Country,Adress)
VALUES
('1111111','Mustafa','5312685323','m.hikmet.ozturk@gmail.com','Türkiye','311 sokak no 11'),
('1111112','Gürcan','5682561524','gurcanrk@gmail.com','Ýngiltere','598 sokak no 1'),
('1111113','Enes','5362541526','enes@gmail.com','Türkiye','999 sokak no 10'),
('1111114','Isa','4352556859','mýsa@gmail.com','Türkiye','656 sokak no 2'),
('1111115','Beyza','1524568956','beyza@gmail.com','Almanya','59 sokak no 5'),
('1111116','Miray','3572695162','miray@gmail.com','Türkiye','13 sokak no 8'),
('1111120','Hikmet','5982685457','hikmet.@gmail.com','Türkiye','268 sokak no 111'),
('1111121','Ahmet','5485796268','ahmet.@gmail.com','Ýngiltere','847 sokak no 10');






INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-02-02','1','1111112',0,'Business',0);
INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-02-02','3','1111113',1,'Business',0);
INSERT INTO SEAT_RESERVATION VALUES('IA111','2','2021-02-15','1','1111114',0,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('IA111','2','2021-02-15','2','1111115',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('IA111','2','2021-02-15','3','1111116',0,'Business',0);
INSERT INTO SEAT_RESERVATION VALUES('DT112','3','2021-02-05','1','1111111',1,'Business',0);
INSERT INTO SEAT_RESERVATION VALUES('DT112','3','2021-02-05','2','1111112',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('DT112','3','2021-02-05','3','1111113',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('TD111','4','2021-03-18','1','1111115',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-04-02','1','1111111',1,'Business',0);
INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-04-02','2','1111113',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('AI111','1','2021-04-02','3','1111116',1,'Economy',0);
INSERT INTO SEAT_RESERVATION VALUES('DT112','3','2021-03-05','1','1111116',1,'Economy',0);


