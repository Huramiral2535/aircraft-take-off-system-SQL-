USE [DB_AIRLINE]
GO

/****** Object:  Trigger [dbo].[available_seat]    Script Date: 2.02.2021 20:12:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[available_seat]
on [dbo].[LEG_INSTANCE]
after insert
as
begin
	declare @flight_n VarChar(7)
	declare @leg_n int
	declare @Date date
	declare @arr int
	declare @dep int
	declare @arrt time
	declare @dept time
	declare @available int
	declare @plane_id int
	declare @total_seat int
	select @flight_n=Flight_number ,@leg_n=Leg_number,@Date=Date,@available=Number_of_available_seats,@arr=Arrival_airport_code,
	@dep=Departure_airport_code,@arrt=Arrival_time,@dept=Departure_time,@plane_id=Airplane_id from inserted
	select @total_seat=AIRPLANE.Total_no_of_seat from AIRPLANE where AIRPLANE.Airplane_id =@plane_id
	BEGIN
	IF (@available>@total_seat)begin
		UPDATE LEG_INSTANCE  SET Number_of_available_seats = @total_seat
			FROM LEG_INSTANCE  WHERE Flight_number = @flight_n and Leg_number=@leg_n and Date=@date
		END
	END
	
end

GO

