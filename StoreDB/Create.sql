CREATE DATABASE AgenciaViajes;
GO

use AgenciaViajes;
GO

CREATE TABLE Sex(
	SexId int PRIMARY KEY IDENTITY,
	Sex varchar(25) not null
);
GO

CREATE TABLE Client(
	ClientId int PRIMARY KEY IDENTITY,
	FirstName nvarchar(50) not null,
	LastName nvarchar(50) not null,
	Phone varchar(10) not null,
	Address nvarchar(200) null,
	Mail nvarchar(50) not null,
	Sex int not null REFERENCES Sex(SexId),
	Birthdate date not null,
	Credito int not null DEFAULT 0
);
GO

CREATE TABLE ProductCategory(
	CategoryId int PRIMARY KEY IDENTITY,
	CategoryName nvarchar(50) not null UNIQUE,
	Description nvarchar(200) not null
);
GO

CREATE TABLE Product(
	ProductId int PRIMARY KEY IDENTITY,
	ProductName nvarchar(50) not null,
	Quantity int not null,
	UnitPrice money not null,
	Description nvarchar(200) not null,
	CategoryId int NOT NULL REFERENCES ProductCategory(CategoryId)
);
GO

CREATE TABLE SalesHeader(
	SalesHId int PRIMARY KEY IDENTITY,
	ClientId int REFERENCES Client(ClientId),
	SubTotal money not null DEFAULT 0,
	ITBIS money not null DEFAULT 0,
	Total money not null DEFAULT 0,
	SalesDate DateTime not null
);
GO

CREATE TABLE SalesDetails(
	SalesDId int PRIMARY KEY IDENTITY,
	SalesHId int NOT NULL REFERENCES SalesHeader(SalesHId),
	ProductId int NOT NULL REFERENCES Product(ProductId),
	Quantity int not null,
	UnitPrice money not null,
	ITBIS money not null
);
GO


