
USE [DB_AIRLINE]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[price_ffc_control]
on [dbo].[SEAT_RESERVATION]
after insert,update
as
begin
	declare @pass VarChar(7)
	declare @f_no Varchar(9)
	declare @dates date
	declare @leg_no int
	declare @seat_no int
	declare @cek bit
	declare @koltuk varchar(10)
	declare @mill float
	declare @price float
	declare @times float
	declare @level Varchar(10)
	select @f_no=Flight_number,@leg_no=Leg_number,@dates=Date,@seat_no=Seat_number,@pass=Passport_number,@cek=Check_in,@koltuk=Seat_type from inserted
	select @price=fa.Amonuts from fares as fa,SEAT_RESERVATION as s,LEG_INSTANCE as leg,FLIGHT_LEG as fl, FLIGHT as f 
	where @f_no=leg.Flight_number and @leg_no=leg.Leg_number and @dates=leg.Date
	and leg.Flight_number=fl.Flight_number and leg.Leg_number=fl.Leg_number
	and fl.Flight_number=f.Flight_number
	and f.Flight_number=fa.Flight_number
	and @koltuk=fa.Restrictions
	Update SEAT_RESERVATION  set Seat_Amount=@price From SEAT_RESERVATION as s where s.Flight_number=@f_no and s.Leg_number=@leg_no and s.Date=@dates and s.Seat_number=@seat_no

		Select
		@level='Start',
		@mill=SUM(fl.Milleage),
		@times=COUNT(fl.Milleage),
		@price=SUM(s.Seat_Amount)
		from SEAT_RESERVATION as s,LEG_INSTANCE as leg,FLIGHT_LEG as fl
		where s.Check_in=1
		and s.Date=leg.Date
		and s.Flight_number = leg.Flight_number
		and s.Leg_number = leg.Leg_number
		and leg.Flight_number = fl.Flight_number
		and leg.Leg_number = fl.Leg_number
		GROUP BY s.Passport_number


	IF EXISTS(Select * FROM FFC WHERE FFC.Passport_number=@pass)
	BEGIN
	UPDATE FFC SET FFC.total_mil = @mill, FFC.Times_Flew=@times ,FFC.Total_price=@price, FFC.Mil_point=((((@mill*0.1)+(@price*0.1))*(@times/2))*0.3),FFC.Segment_point=(((@mill*0.1)+(@price*0.1))*(@times/2))
		FROM FFC WHERE FFC.Passport_number = @pass
	END
	ELSE IF(@cek=0) begin
		print 'Check_in yapýlmamýstýr.';
	end
	Else IF NOT EXISTS(Select * FROM FFC WHERE FFC.Passport_number=@pass)
	Insert into FFC(Passport_number,Total_price,Total_mil,Times_Flew,Mil_point,Segment_point,Segment_level)
	Values(@pass,@price,@mill,@times,((((@mill*0.1)+(@price*0.1))*(@times/2))*0.3),(((@mill*0.1)+(@price*0.1))*(@times/2)),@level)


	
end

GO

