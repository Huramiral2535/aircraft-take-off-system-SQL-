USE [DB_AIRLINE]
GO

/****** Object:  Trigger [dbo].[FightDateControl]    Script Date: 2.02.2021 20:12:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[FightDateControl] ON [dbo].[SEAT_RESERVATION]
AFTER INSERT
AS
declare @flightnumber varchar(9)
declare @bugun date 
declare @s_no int
declare @leg_no int
declare @flightDate date
select @flightnumber=Flight_number,@leg_no=Leg_number,@flightDate=Date,@s_no=Seat_number from inserted
select @bugun=GETDATE()


BEGIN

IF (@bugun>@flightDate)
begin
    print 'uçuş tarihi geçmiş rezerve edilemez'
	
    ROLLBACK TRANSACTION
	
	Delete from SEAT_RESERVATION where SEAT_RESERVATION.Flight_number=@flightnumber and SEAT_RESERVATION.Leg_number=@leg_no and SEAT_RESERVATION.Date=@flightDate and SEAT_RESERVATION.Seat_number=@s_no

	end

END;



GO

