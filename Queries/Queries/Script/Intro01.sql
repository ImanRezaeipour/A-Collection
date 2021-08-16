USE MASTER;
GO
CREATE DATABASE RecordAnatomy;
GO 
USE RecordAnatomy;
GO
SELECT * FROM sys.sysfiles
SP_HELPFILE
GO
CREATE TABLE Example
(
	FirstName VARCHAR(100), 
	LastName VARCHAR(100), 
	Age INT
);
GO
INSERT INTO Example VALUES ('Masoud', 'Taheri', 29);
INSERT INTO Example VALUES ('Farid', 'Taheri', 28);
GO
SELECT * FROM Example 
GO
/*And we can use DBCC IND again to find the page to look at: 
PageFID : Data FileID
PagePID : Page ID
*/
DBCC IND ('RecordAnatomy', 'Example', 1);
GO 
DBCC TRACEON (3604)
DBCC PAGE ('RecordAnatomy', 1, 77, 3);
GO 
------------------------------
--بررسی جزئی در مورد ساختار لاگ فایل
USE RecordAnatomy
GO
DBCC LOG('RecordAnatomy')--مشاهده محتوای لاگ فایل
GO
ALTER DATABASE RecordAnatomy SET RECOVERY SIMPLE --تغییر نحوه رفتار لاگ فایل هنگام ذخیره اطلاعات به چه صورتی باشد
GO
CHECKPOINT --صفحات داده های آن در حافظه یافته به دیسک منتقل می شود 
GO
CREATE TABLE T1
(
	F1 INT
)
GO
DBCC LOG('RecordAnatomy')--مشاهده محتوای لاگ فایل
GO
CHECKPOINT --صفحات داده های آن در حافظه یافته به دیسک منتقل می شود 
GO
DBCC LOG('RecordAnatomy')--مشاهده محتوای لاگ فایل
GO
INSERT INTO T1 VALUES (1)
GO
DBCC LOG('RecordAnatomy')--مشاهده محتوای لاگ فایل
GO
select * from t1