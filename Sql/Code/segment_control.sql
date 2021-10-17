
USE [DB_AIRLINE]
GO

/****** Object:  Trigger [dbo].[ffc_control]    Script Date: 2.02.2021 20:12:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[segment_control]
on [dbo].[FFC]
after insert,update
as
begin
	declare @pass VarChar(7)
	declare @point float

	select @point=FFC.Segment_point,@pass=FFC.Passport_number from FFC 

	IF(@point>300)BEGIN
		update FFC SET FFC.Segment_level='BRONZ' where FFC.Passport_number=@pass
	END
	IF(@point>800)BEGIN
		update FFC SET FFC.Segment_level='SILVER' where FFC.Passport_number=@pass
	END
	IF(@point>1500)BEGIN
		update FFC SET FFC.Segment_level='GOLD' where FFC.Passport_number=@pass
	END
	IF(@point>5000)BEGIN
		update FFC SET FFC.Segment_level='PLATINUM' where FFC.Passport_number=@pass
	END
	IF(@point>1500)BEGIN
		update FFC SET FFC.Segment_level='DIAMOND' where FFC.Passport_number=@pass
	END
	
end

GO

