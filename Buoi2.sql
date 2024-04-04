USE express_mssql_core

CREATE TABLE Product(
	id int IDENTITY(1,1) PRIMARY KEY,
	productName nvarchar(255) NOT NULL,
	price float NOT NULL
)
--Copy bảng
SELECT * INTO ProductCopy FROM Product

SELECT * FROM Product
SELECT * FROM ProductCopy

--DROP TABLE
DROP TABLE ProductCopy

--ALTER TABLE - ADD COLUMN
ALTER TABLE ProductCopy
ADD productImage nvarchar(255) NOT NULL

--ALTER TABLE - DROP COLUMN
ALTER TABLE ProductCopy
DROP COLUMN productImage

--ALTER TABLE - RENAME COLUMN
EXEC sp_rename  'ProductCopy.productName', 'productname'

--ALTER TABLE - ALTER/MODIFY DATATYPE
ALTER TABLE ProductCopy
ALTER COLUMN productname nchar(20)

--Constraints

--SQL NOT NULL Constraint
CREATE TABLE Persons (
    id int NOT NULL,
    lastName varchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int
);

--SQL NOT NULL on ALTER TABLE
ALTER TABLE Persons
ADD email nvarchar(255) NOT NULL

ALTER TABLE Persons
ALTER COLUMN age int NOT NULL

--SQL UNIQUE 
--CREATE TABLE Person (
    --id int NOT NULL UNIQUE PRIMARY KEY,
    --lastName varchar(255) NOT NULL,
	--email nvarchar(255) NOT NULL,
    --firstName varchar(255) NOT NULL,
    --age int
--);

CREATE TABLE Person (
    id int NOT NULL,
    lastName varchar(255) NOT NULL,
	 email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int
	CONSTRAINT UC_Person UNIQUE(id, email)
);

--SQL UNIQUE Constraint on ALTER TABLE
ALTER TABLE Person
ADD UNIQUE age

ALTER TABLE Person
ADD CONSTRAINT UC_Person UNIQUE (age);

--DROP a UNIQUE Constraint
ALTER TABLE Persons
DROP CONSTRAINT UC_Person;

--SQL PRIMARY KEY Constraint
CREATE TABLE Person1 (
    id int NOT NULL PRIMARY KEY,
    lastName varchar(255) NOT NULL,
	 email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int
);

CREATE TABLE Person2 (
    id int NOT NULL,
    lastName varchar(255) NOT NULL,
	 email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int
	CONSTRAINT PK_Person2 PRIMARY KEY(id)
);

--SQL PRIMARY KEY on ALTER TABLE
ALTER TABLE Person1
ADD PRIMARY KEY (id)

ALTER TABLE Person1
ADD CONSTRAINT PK_Person1 PRIMARY KEY (id)

--DROP a PRIMARY KEY Constraint
ALTER TABLE Person2
DROP CONSTRAINT PK_Person2;

--SQL FOREIGN KEY Constraint
--C1
CREATE TABLE Orders(
	id int IDENTITY(1,1) PRIMARY KEY,
	orderName nvarchar(255) NOT NULL,
	personId int FOREIGN KEY REFERENCES Person(id)
)
--C2
CREATE TABLE Orders(
	id int IDENTITY(1,1) PRIMARY KEY,
	orderName nvarchar(255) NOT NULL,
	personId int NOT NULL
	CONSTRAINT FK_PersonOrder FOREIGN KEY (personId) REFERENCES Person(id)
)

--SQL FOREIGN KEY on ALTER TABLE
ALTER TABLE Orders
ADD FOREIGN KEY (personId) REFERENCES Person(id)

ALTER TABLE Orders
ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (personId) REFERENCES Person(id)

--DROP a FOREIGN KEY Constraint
ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;

--SQL CHECK Constraint
CREATE TABLE Person1 (
    id int NOT NULL PRIMARY KEY,
    lastName varchar(255) NOT NULL,
	 email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int CHECK (age > 18)
);
CREATE TABLE Person1 (
    id int NOT NULL PRIMARY KEY,
    lastName varchar(255) NOT NULL,
	email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    age int
	CONSTRAINT CHK_Person CHECK (age > 18 AND firstName = N'Dung')
);

--SQL CHECK on ALTER TABLE
ALTER TABLE Person
ADD CHECK (age > 18);

ALTER TABLE Person
ADD CONSTRAINT CHK_Person CHECK (age > 18)

ALTER TABLE Person
DROP CONSTRAINT CHK_Person

--SQL DEFAULT Constraint
CREATE TABLE Person (
    id int NOT NULL PRIMARY KEY,
    lastName varchar(255) NOT NULL,
	email nvarchar(255) NOT NULL,
    firstName varchar(255) NOT NULL,
    city nvarchar(255) DEFAULT 'NINH BINH'
);

--SQL DEFAULT on ALTER TABLE

ALTER TABLE Person
ADD City nvarchar(255) NOT NULL

ALTER TABLE Person
ADD CONSTRAINT df_City
DEFAULT 'NINH BINH' FOR City

--DROP a DEFAULT Constraint
ALTER TABLE Person
DROP CONSTRAINT df_City


SELECT * FROM Person

--Create index
CREATE INDEX idx_email
ON Person (email)
--Delete index
DROP INDEX Person.idx_email;

--AUTO INCREMENT Field: IDENTITY(1,1)

SELECT GETDATE()

SELECT * FROM Person

--VIEW
--CREATE
CREATE VIEW vw_select_all_person
AS
SELECT id, firstName, lastName
FROM Person


SELECT * FROM vw_select_all_person

--UPDATE
ALTER  VIEW vw_select_all_person
AS
SELECT id, firstName, lastName, age
FROM Person

DROP VIEW vw_select_all_person;
