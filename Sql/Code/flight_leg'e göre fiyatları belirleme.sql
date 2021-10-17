USE [DB_AIRLINE]
GO

/****** Object:  Trigger [dbo].[calc_amounts]    Script Date: 2.02.2021 20:11:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[Add_fares]
   ON  [dbo].[FLIGHT_LEG]
AFTER INSERT
AS 
BEGIN
	declare @Milleage int
	declare @fNumber varchar(9)
	declare @airline varchar(30)
	declare @week varchar(20)
	select @fNumber=Flight_number from inserted
	select @Milleage=Milleage from FLIGHT_LEG  where @fNumber=Flight_number 
	select @week=FLIGHT.Weekdays from FLIGHT,FLIGHT_LEG where FLIGHT.Flight_number=@fNumber
	select @airline=AIRLINE.Airline_name from AIRLINE,FLIGHT where AIRLINE.Airline_id=FLIGHT.Airline_id and FLIGHT.Flight_number=@fNumber
	BEgin
-----------------------------------------------------------------------------
--0,75 $ per mile--
-------------------------------------------------------------------------------
	IF(@week='Haftaiçi') begin
		IF(@airline='Türk Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.75,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*2,'Business')
		end
			ELSE IF(@airline='SunExpress Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.70,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*1.80,'Business')
		end
			ELSE IF(@airline='Pegasus Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.72,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*1.90,'Business')
		end
	END
	ELSE IF(@week='Haftasonu') begin
		IF(@airline='Türk Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.80,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*2.10,'Business')
		end
			ELSE IF(@airline='SunExpress Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.75,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*1.90,'Business')
		end
			ELSE IF(@airline='Pegasus Hava Yollarý') begin
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,0,@Milleage*0.77,'Economy')
			Insert into FARES(Flight_number,Fare_code,Amonuts,Restrictions) Values(@fNumber,1,@Milleage*2,'Business')
		end
	END
end
END
GO

