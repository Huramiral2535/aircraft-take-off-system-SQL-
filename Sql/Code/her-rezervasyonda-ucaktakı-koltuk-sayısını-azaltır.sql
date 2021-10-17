USE [DB_AIRLINE]
GO

/****** Object:  Trigger [dbo].[available_seat_count]    Script Date: 2.02.2021 20:12:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[available_seat_count]
on [dbo].[SEAT_RESERVATION]
after insert
as
begin
	declare @flight_n VarChar(7)
	declare @leg_n int
	declare @Date date
	declare @available int
	select @flight_n=Flight_number ,@leg_n=Leg_number,@Date=Date from inserted

	select @available=Number_of_available_seats from LEG_INSTANCE where Flight_number =@flight_n
	and leg_number=@leg_n
	and Date=@Date

	BEGIN
	
	IF(@available>0) begin
		UPDATE LEG_INSTANCE  SET Number_of_available_seats = (Number_of_available_seats-1)
				FROM LEG_INSTANCE  WHERE Flight_number = @flight_n and Leg_number=@leg_n and Date=@date
		END
	END
	IF(@available<=0) BEGIN
		print 'uçuþ için koltuk kalmadý rezerve edilemez'
	END
	
end
GO

