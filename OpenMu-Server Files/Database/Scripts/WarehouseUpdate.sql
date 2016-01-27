Use MuOnline
GO
--////////////////////////////////////////////////////////////////////////////

ALTER TABLE [MuOnline].[dbo].[warehouse] add 
[Number] int not null default 0
GO

--////////////////////////////////////////////////////////////////////////////


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ExtWarehouse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ExtWarehouse]
GO

CREATE TABLE [dbo].[ExtWarehouse] (
        [AccountID] [varchar] (10) NOT NULL ,
	[Items] [varbinary] (3840) NULL ,
	[Money] [int] NOT NULL ,
        [Number] [int] NOT NULL
) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WarehouseChange]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WarehouseChange]
GO

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WarehouseChange] @Number1 int,@Account varchar(10) as

BEGIN

SET NOCOUNT ON

DECLARE @Number2 int
DECLARE @Items1 varbinary(3840)
DECLARE @Items2 varbinary(3840)
DECLARE @Money1 int
DECLARE @Money2 int 
DECLARE @return int

SET	XACT_ABORT ON

SET @return = 0

BEGIN TRANSACTION

SELECT @Items1=Items,@Money1=Money,@Number2=Number FROM warehouse WHERE AccountID=@Account

if(@@ROWCOUNT < 1)
BEGIN
    SET @return = 1
    GOTO CheckTran
END
	
    if not @Number2=@Number1
    BEGIN     

        if not EXISTS (SELECT AccountID FROM ExtWarehouse WHERE AccountID=@Account AND Number=@Number1)
        BEGIN

	    INSERT INTO ExtWarehouse (AccountID,Items,Money,Number) VALUES (@Account,cast(REPLICATE(char(0xff),3840) as varbinary(3840)),0,@Number1)

        if(@@error <> 0)
	    BEGIN
            SET @return = 1
            GOTO CheckTran
	    END

        END

        if not EXISTS (SELECT AccountID FROM ExtWarehouse WHERE AccountID=@Account AND Number=@Number2) begin

	    INSERT INTO ExtWarehouse (AccountID,Items,Money,Number) VALUES (@Account,cast(REPLICATE(char(0xff),3840) as varbinary(3840)),0,@Number2)

        if(@@error <> 0)
	    BEGIN
            SET @return = 1
            GOTO CheckTran
	    END

        end

        UPDATE ExtWarehouse SET Items=@Items1,Money=@Money1,Number=@Number2 WHERE AccountID=@Account AND Number=@Number2

        if(@@error <> 0)
	    BEGIN
            SET @return = 1
            GOTO CheckTran
	    END
 
        SELECT @Items2=Items,@Money2=Money FROM ExtWarehouse WHERE AccountID=@Account AND Number=@Number1

        if(@@error <> 0)
	    BEGIN
            SET @return = 1
            GOTO CheckTran
	    END

        UPDATE warehouse SET Items=@Items2,Money=@Money2,Number=@Number1 WHERE AccountID=@Account

        if(@@error <> 0)
	    BEGIN
            SET @return = 1
            GOTO CheckTran
	    END

    END

CheckTran:
if(@return <> 0)
BEGIN
    ROLLBACK TRANSACTION
END

else

BEGIN
    COMMIT TRANSACTION
END

SELECT @return

SET	XACT_ABORT OFF
set nocount off
END