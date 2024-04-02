--Tạo DB
CREATE DATABASE express_mssql_core
USE express_mssql_core
--Xóa DB
DROP DATABASE express_mssql_core
--Liệt kê các database
SELECT * FROM sys.databases WHERE NAME NOT IN ('master', 'tempdb', 'model', 'msdb'); 
--Backup dữ liệu
BACKUP DATABASE SHOP
TO DISK = 'D:\Workspace\mssql\backups\express_mssql_core.bak'
--Bản sao lưu khác biệt chỉ sao lưu các phần cơ sở dữ liệu đã thay đổi kể từ lần sao lưu cơ sở dữ liệu đầy đủ gần đây nhất.
WITH DIFFERENTIAL
--Tạo bảng
CREATE TABLE Users(
	id int IDENTITY(1,1) PRIMARY KEY,
	firstName nvarchar(255) NOT NULL,
	lastName nvarchar(255) NOT NULL,
	email nvarchar(255) NOT NULL,
	password nvarchar(255) NOT NULL,
	isAdmin bit NOT NULL DEFAULT 0,
	createdAt datetime DEFAULT CURRENT_TIMESTAMP,
	updatedAt datetime DEFAULT CURRENT_TIMESTAMP
)
--Tạo bảng UsersCopy và copy toàn bộ bản ghi sang bảng UsersCopy
SELECT * INTO UsersCopy from Users

SELECT * FROM Users

--Thêm 1 hàng
INSERT INTO Users(firstName, lastName, email, password) VALUES(N'Dung', N'Tran', N'trandungksnb00@gmail.com', N'Tranvandung2001@')
--Chỉnh sửa
UPDATE Users
SET firstName = N'Dũng'
WHERE id = 1

--Trigger auto updatedAt
CREATE TRIGGER trg_users_updateAt ON Users FOR UPDATE AS
BEGIN
  UPDATE Users
	SET updatedAt = CURRENT_TIMESTAMP
	FROM Users INNER JOIN deleted d
	ON Users.id=d.id
END

--Stored Procedure 
CREATE PROCEDURE SelectAllUsers
AS
SELECT * FROM Users

EXEC SelectAllUsers;

