--���Դ���
DECLARE @retry INT

SET @retry = 3

WHILE ( @retry > 0 ) 
    BEGIN
        BEGIN TRY
   --������ҵ�����
   
   --����ɹ��������Դ�����Ϊ
            SET @retry = 0
        END TRY
   
        BEGIN CATCH
   --�����������������
            IF ( ERROR_NUMBER() = 1205 ) 
                SET @retry = @retry - 1
            ELSE 
                BEGIN
      --������������󣬼�¼����־��..
                END
      
        END CATCH
    END