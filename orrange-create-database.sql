-- This SQL is used to create the Orrange database that supports the Fall 2024 IST-659 Group 1 project.

-- This block of SQL checks for the existence of orrange, and drops/recreates it.
use master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'orrange') 
drop database orrange;
GO

create database orrange;
GO

ALTER DATABASE orrange SET RECOVERY SIMPLE;

use orrange;
GO

-- Drop the PK of the users table then drop the users table.  Create both again in proper order.
IF EXISTS (SELECT name FROM   sys.key_constraints WHERE  [type] = 'PK' AND [parent_object_id] = Object_id('dbo.users'))
alter table users drop constraint pk_user_id;
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[users]') AND type in (N'U'))
DROP TABLE [dbo].[users];
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_email] [varchar](100) NOT NULL,
	[user_firstname] [varchar](50) NOT NULL,
	[user_lastname] [varchar](50) NOT NULL,
	[user_zip_code] [char](5) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [pk_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO