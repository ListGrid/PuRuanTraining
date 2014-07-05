/*--------1.系统存储过程的使用-----------*/
USE bbsDB
GO
EXEC sp_helpconstraint bbsUsers --查看表stuInfo的约束
EXEC sp_helpindex bbsUsers  --查看表stuMarks的索引
USE master
GO
EXEC xp_cmdshell 'mkdir d:\project\test', NO_OUTPUT  --创建文件夹D:\bank 
EXEC xp_cmdshell 'dir D:\project\' --查看文件夹
GO

/*--------2.带参数的存储过程-----------*/

USE bbsDB
GO
/*
--评选奖项或调查某个用户的发表的言论
--查找某个用户的发贴情况（发主贴和回帖）
*/
/*---检测是否存在：存储过程存放在系统表sysobjects中---*/
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'proc_find1' )
  DROP PROCEDURE  proc_find1
GO

CREATE PROCEDURE proc_find1
  @userName varchar(10)
   AS 
     SET NOCOUNT ON
     DECLARE @userID varchar(10)
     SELECT @userID=UID FROM bbsUsers WHERE Uname=@userName --获取心酸果冻的用户编号
     IF EXISTS(SELECT * FROM bbsTopic WHERE TuID=@userID)
        BEGIN
           print @userName+'发表的主贴如下:'
           SELECT 发贴时间=convert(varchar(10),Ttime,111),点击率=TclickCount, 
             主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TuID=@userID
        END
     ELSE
        print @userName+'没有发表过主贴。'
     IF EXISTS(SELECT * FROM bbsReply WHERE RuID=@userID)
        BEGIN
           print @userName+'发表的回贴如下:'
           SELECT 回贴时间=convert(varchar(10),Rtime,111),点击率=RclickCount,
              回贴内容=Rcontents FROM bbsReply WHERE RuID=@userID
        END
     ELSE
        print @userName+'没有发表过回贴。'
GO

EXEC proc_find1 '可卡因'

/*--------3.带返回值的存储过程-----------*/  
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'proc_find2' )
  DROP PROCEDURE  proc_find2
GO

CREATE PROCEDURE proc_find2
  @userName varchar(10),
  @sumTopic INT OUTPUT,
  @sumReply INT OUTPUT 
   AS 
     SET NOCOUNT ON
     DECLARE @userID varchar(10)
     SELECT @userID=UID FROM bbsUsers WHERE Uname=@userName --获取心酸果冻的用户编号
     IF EXISTS(SELECT * FROM bbsTopic WHERE TuID=@userID)
        BEGIN
           SELECT @sumTopic=count(*) FROM bbsTopic WHERE TuID=@userID
           print @userName+'发表的主贴如下:'
           SELECT 发贴时间=convert(varchar(10),Ttime,111),点击率=TclickCount, 
             主题=Ttopic,内容=Tcontents FROM bbsTopic WHERE TuID=@userID
        END
     ELSE
        BEGIN
           SET @sumTopic=0
           print @userName+'没有发表过主贴。'
        END
     IF EXISTS(SELECT * FROM bbsReply WHERE RuID=@userID)
        BEGIN
           SELECT @sumReply=count(*) FROM bbsReply WHERE RuID=@userID
           print @userName+'发表的回贴如下:'
           SELECT 回贴时间=convert(varchar(10),Rtime,111),点击率=RclickCount,
              回贴内容=Rcontents FROM bbsReply WHERE RuID=@userID
        END
     ELSE
        BEGIN
           SET @sumReply=0
           print @userName+'没有发表过回贴。'
        END
GO

DECLARE @sum1 INT ,@sum2 INT
EXEC proc_find2 '可卡因',@sum1 OUTPUT,@sum2 OUTPUT
IF @sum1>=@sum2
   print '小弟发贴较多，看来比较喜欢打抱不平！'
ELSE
   print '小弟回帖较多，看来比较关心民众疾苦！'

print '总贴数: '+convert(varchar(5),@sum1+@sum2 )
GO


/*---------------
--显示目前的最新排名
SELECT 昵称=Uname,星级=CASE
                         WHEN Uclass=0 THEN ' '
                         WHEN Uclass=1 THEN '★'
                         WHEN Uclass=2 THEN '★★'
                         WHEN Uclass=3 THEN '★★★'
                         WHEN Uclass=4 THEN '★★★★'
                         WHEN Uclass=5 THEN '★★★★★'
                         ELSE               '★★★★★★'
                      END
   ,积分=Upoint FROM bbsUsers
GO
---------------------------------------
SELECT * FROM BBSUsers  --用户表
SELECT * FROM bbsTopic    --主贴表
SELECT * FROM bbsReply    --回帖表
SELECT * FROM bbsSection  --版块表
--------------------*/
