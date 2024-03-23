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
