USE master
GO
/*---����Ƿ��Ѵ���bbsDB���ݿ⣺��ѯmaster���ݿ��е�ϵͳ��sysdatabases---*/
IF EXISTS (SELECT * FROM sysdatabases WHERE name = 'bbsDB')
	DROP DATABASE bbsDB
GO
EXEC xp_cmdshell 'mkdir D:\SQLServerDb'  --����DOS������ļ��У������½ڽ�����
/*-----����--------*/
CREATE DATABASE bbsDB
 ON 
 (
  /*----�����ļ��ľ�������--*/
  NAME = 'bbsDB_data', --�������ļ����߼���
  FILENAME = 'D:\SQLServerDb\bbsDB_data.mdf' , --�������ļ���������
  SIZE = 10 MB,  --�������ļ���ʼ��С
  FILEGROWTH = 20%   --�������ļ���������
 ) 
 LOG ON 
 (
  /*----��־�ļ��ľ�������������������ͬ��--*/
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

