USE Northwind
GO
--IOفعال سازي آمار
--مفاهيم زير شرح داده شود
--Phisical Read
--Logical Read
--Read Ahead 
SET STATISTICS IO ON
GO
--تعداد صفحات واکشی شده بررسی گردد
SELECT * FROM Orders
GO
--خالی کردن محتوای حافظه تخصیص داده شده به ازای صفحات
DBCC DROPCLEANBUFFERS
GO
--تعداد صفحات واکشی شده بررسی گردد
SELECT OrderID,OrderDate FROM Orders
GO
SET STATISTICS IO OFF
GO
--خالی کردن محتوای حافظه تخصیص داده شده به ازای صفحات
DBCC DROPCLEANBUFFERS
GO
---------------------------
--فعال سازی آمار زمان اجرا
SET STATISTICS TIME ON
--تعداد صفحات واکشی شده بررسی گردد
SELECT * FROM Orders
GO
--خالی کردن محتوای حافظه تخصیص داده شده به ازای صفحات
DBCC DROPCLEANBUFFERS
GO
--تعداد صفحات واکشی شده بررسی گردد
SELECT OrderID,OrderDate FROM Orders
GO
SET STATISTICS TIME OFF
GO
---------------------------------
--Execution Plane مشاهده 
--نقشه اجرایی در واقع نحوه اجرا شدن یک کوئری را مشخص می کند
--به این موضوع اصطلاحا ترتیب اجرای فیزیکی کوئری می گویند
GO
--Execution Plane بررسی 
SELECT * FROM Orders
GO
--Execution Plane بررسی انواع
SELECT * FROM Orders
GO
--Execution Plane بررسی نحوه خواندن
SELECT * FROM Orders
	INNER JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
GO