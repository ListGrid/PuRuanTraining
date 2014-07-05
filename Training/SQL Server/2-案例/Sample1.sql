--重试次数
DECLARE @retry INT

SET @retry = 3

WHILE ( @retry > 0 ) 
    BEGIN
        BEGIN TRY
   --这里是业务代码
   
   --事务成功，将重试次数变为
            SET @retry = 0
        END TRY
   
        BEGIN CATCH
   --如果是死锁，则重试
            IF ( ERROR_NUMBER() = 1205 ) 
                SET @retry = @retry - 1
            ELSE 
                BEGIN
      --如果是其它错误，记录到日志等..
                END
      
        END CATCH
    END