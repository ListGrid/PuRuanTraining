USE master
GO
/*---检查是否已存在bbsDB数据库：查询master数据库中的系统表sysdatabases---*/
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'bbsDB')
	DROP DATABASE bbsDB
GO
EXEC xp_cmdshell 'mkdir D:\SQLServerDb'  --调用DOS命令创建文件夹，后续章节将讲解
/*-----建库--------*/
CREATE DATABASE bbsDB
 ON 
 (
  /*----数据文件的具体描述--*/
  NAME = 'bbsDB_data', --主数据文件的逻辑名
  FILENAME = 'D:\SQLServerDb\bbsDB_data.mdf' , --主数据文件的物理名
  SIZE = 10 MB,  --主数据文件初始大小
  FILEGROWTH = 20%   --主数据文件的增长率
 ) 
 LOG ON 
 (
  /*----日志文件的具体描述，各参数含义同上--*/
  NAME = 'bbsDB_log', 
  FILENAME = 'D:\SQLServerDb\bbsDB_log.ldf' ,
  SIZE = 1MB, 
  MAXSIZE = 20MB,
  FILEGROWTH = 10%
 )
GO

USE bbsDB
GO

/*
DROP TABLE bbsDBREPLY
GO
*/
CREATE TABLE DBO.Product (
	LineID INT IDENTITY (1, 1) NOT NULL ,
	Product VARCHAR (32) COLLATE CHINESE_PRC_CI_AS NOT NULL ,
	Price REAL NOT NULL ,
	Quantity REAL NOT NULL ,
	LineTotal REAL NOT NULL
)
GO

SELECT * FROM Product
GO

