
USE [DB_AIRLINE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[company_control1]
on [dbo].[AIRLINE]
after insert
as
begin
	declare @compid int
	declare @lineid int
	declare @linename varchar(30)
	select @compid=Company_id,@lineid=Airline_id, @linename=Airline_name From inserted 
	IF  EXISTS(select * from AIRLINE as al, AIRPLANE as ap, AIRPLANE_TYPE as apt where al.Company_id=ap.Company_id and al.Company_id=apt.Company_id) 
	Begin
			ROLLBACK TRANSACTION
			print 'Bu company airline companysi olamaz.';

	end	
end
GO

CREATE TRIGGER [dbo].[company_control2]
on [dbo].[AIRPLANE]
after insert
as
begin
	declare @compid int
	declare @lineid int
	declare @linename varchar(30)
	IF  EXISTS(select * from AIRLINE as al, AIRPLANE as ap where al.Company_id=ap.Company_id ) 
	Begin
			ROLLBACK TRANSACTION
			print 'Bu company airplane companysi olamaz.';

	end	


END
go

CREATE TRIGGER [dbo].[company_control3]
on [dbo].[AIRPLANE_TYPE]
after insert
as
begin
	declare @compid int
	declare @lineid int
	declare @linename varchar(30)
	IF  EXISTS(select * from AIRLINE as al, AIRPLANE_TYPE as apt where al.Company_id=apt.Company_id ) 
	Begin
			ROLLBACK TRANSACTION
			print 'Bu companynýn bir airplane_typesi olamaz.';

	end	


END

