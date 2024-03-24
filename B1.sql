CREATE DATABASE SHOP

USE SHOP

GO

CREATE TABLE Categories(
	CategoryId int IDENTITY(1,1) PRIMARY KEY,
	CategoryName nvarchar(255) NOT NULL,
	Description nvarchar(255) NULL,
	Picture nvarchar(255) NOT NULL
)

SELECT * FROM [dbo].[Categories]

SELECT [CategoryId], [CategoryName] FROM [dbo].[Categories]

CREATE TABLE Products(
	ProductId int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(255) NOT NULL,
	SupplierId int NOT NULL,
	--C1
	--CategoryId int NOT NULL,
	--FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),

	--C2
	--CategoryId int FOREIGN KEY REFERENCES Categories(CategoryId)
	--C3
	CategoryId int NOT NULL,
	CONSTRAINT FK_CategoryProduct FOREIGN KEY (CategoryId)
    REFERENCES Categories(CategoryId)
)

CREATE TABLE Suppliers(
	SupplierId int IDENTITY(1,1) PRIMARY KEY,
	CompanyName nvarchar(255) NOT NULL,
	ContactName nvarchar(255) NOT NULL,
	ContactTitle nvarchar(255) NOT NULL,
	Address nvarchar(255) NOT NULL,
	City nvarchar(100) NOT NULL,
	Region nvarchar(255) NOT NULL,
	PostalCode nchar(10) NOT NULL,
	Country nvarchar(50) NOT NULL,
	Phone nchar(11) NOT NULL,
	Fax nvarchar(255) NOT NULL,
	HomePage nvarchar(255) NOT NULL
)

--SQL FOREIGN KEY on ALTER TABLE
ALTER TABLE Products
ADD FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId);

ALTER TABLE Products
ADD CONSTRAINT FK_SupplierProduct
FOREIGN KEY (SupplierId) REFERENCES Suppliers(SupplierId);

--DROP a FOREIGN KEY Constraint
ALTER TABLE Products
DROP CONSTRAINT FK_CategoryProduct;


--Backup
BACKUP DATABASE SHOP
TO DISK = 'D:\Workspace\mssql\backups\SHOP.bak'
--'D:\backups\SHOP.bak'
--Bản sao lưu khác biệt chỉ sao lưu các phần cơ sở dữ liệu đã thay đổi kể từ lần sao lưu cơ sở dữ liệu đầy đủ gần đây nhất.
WITH DIFFERENTIAL