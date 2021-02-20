use AdventureWorks2012

/*
1- La tabla HumanResources.Employee no contiene el nombre de los empleados., usted
debe crear un join con la tabla Person.Person con la columna BusinessEntityID. 
Mostrando el job title, Birth Date, First name y Last Name.
*/
select e.JobTitle, e.BirthDate, p.FirstName, p.LastName
from HumanResources.Employee as e inner join  Person.Person as p
	on e.BusinessEntityID = p.BusinessEntityID



/*
2- El nombre de los clientes tambien aparece en la tabla Person.Person usando la columna
BusinessEntityId este se machea con la columna PersonID de la de la tabla
Sales.Customer. CustomerID, StoreID, y TerritoryID
*/
select c.CustomerID, c.StoreID, c.TerritoryID
from Person.Person as p inner join  Sales.Customer as c
	on p.BusinessEntityID = c.PersonID



/*
3- Actualice el query anterior para incluir Sales.SalesOrderHeader para mostrar el
SalesOrderID con las columnas PersonID de la de la tabla Sales.Customer. CustomerID,
StoreID, y TerritoryID de la tabla customerID.
*/
select sh.SalesOrderID, c.PersonID , c.CustomerID,  c.StoreID, c.TerritoryID
from Person.Person as p inner join  Sales.Customer as c
	on p.BusinessEntityID = c.PersonID
inner join Sales.SalesOrderHeader as sh
	on c.CustomerID = sh.CustomerID
	order by sh.SalesOrderID



/*
4- Escriba un Query que combine las tablas Sales.SalesOrderHeader y la tabla
Sales.SalesPerson. Combine el BusinessEntityID de la tabla Sales.SalesPerson con la
columna SalesPersonID de la tabla Sales.SalesOrderHeader table. Muestre el
SalesOrderID con las cuotas de la columna SalesQuota y Bonus.
*/
select distinct soh.SalesPersonID, sp.SalesQuota, sp.Bonus
from Sales.SalesOrderHeader as soh inner join Sales.SalesPerson as sp
	on soh.SalesPersonID = sp.BusinessEntityID



/*
5- Anada el nombre del cliente al query anterior.
*/
select distinct soh.SalesPersonID, 
				sp.SalesQuota, 
				sp.Bonus, 
				p.FirstName + ' ' + p.LastName [Nombre]
from Sales.SalesOrderHeader as soh inner join Sales.SalesPerson as sp
	on soh.SalesPersonID = sp.BusinessEntityID
inner join Sales.Customer as c
	on soh.CustomerID = c.CustomerID
inner join Person.Person as p
	on c.PersonID = p.BusinessEntityID
	order by soh.SalesPersonID


/*
6- La descripción del catalogo (catalog description) para cada producto esta almacenado
en la tabla Production.ProductModel., despliegue las columnas que muestran la
información del producto tales como Color, size con la descripción del catalogo de cada
producto.
*/
select p.ProductID,
		p.Color,
		p.Size,
		p.Style,
		p.Weight,
		pm.CatalogDescription
from Production.Product as p inner join Production.ProductModel as pm
	on p.ProductModelID = pm.ProductModelID


/*
7- Escriba un query que muestre el nombre de los clientes y el nombre de los productos
que ellos han comprado. Serán requeridas 5 tablas
*/
select distinct p.FirstName + ' ' + p.LastName [Nombre],
		prod.Name
from Person.Person as p inner join Sales.Customer as c
	on p.BusinessEntityID = c.PersonID
inner join  Sales.SalesOrderHeader as soh
	on c.CustomerID = soh.CustomerID
inner join Sales.SalesOrderDetail as sod
	on soh.SalesOrderID = sod.SalesOrderID
inner join  Production.Product as prod
	on prod.ProductID = sod.ProductID


/*
8- Escriba un query que muestre todos los productos junto con la columna SalesOrderID
aunque el producto no posea ordenes., el join se hara contra la tabla
sales.SalesOrderDetail usando la columna ProductID.
*/
select *
from Production.Product as p left join Sales.SalesOrderDetail as sod
	on p.ProductID = sod.ProductID


/*
9- Modifique el query anterior para que solo muestre productos que no tengan ordenes
*/
select *
from Production.Product as p left join Sales.SalesOrderDetail as sod
	on p.ProductID = sod.ProductID
where sod.SalesOrderID is null


/*
10- Escriba un query que muestre todas las filas de la tabla Sales.SalesPerson haciendo join
contra la tabla Sales.SalesOrderHeader usando el SalesOrderID aunque la persona no
tenga ordenes. Incluya el SalesPersonID y las ventas YTD (ventas de todo el ano) en el
resultado
*/
select soh.SalesPersonID,
		sp.SalesYTD,
		soh.SalesOrderID
from Sales.SalesPerson as sp left join Sales.SalesOrderHeader as soh
	on  sp.BusinessEntityID = soh.SalesPersonID 
order by sp.BusinessEntityID



/*
11- Modifique el query anterior para incluir el nombre de la persona que hizo la venta.
*/
select p.FirstName + ' ' + p.LastName [Nombre], 
		soh.SalesPersonID,
		sp.SalesYTD,
		soh.SalesOrderID
from Sales.SalesPerson as sp left join Sales.SalesOrderHeader as soh
	on  sp.BusinessEntityID = soh.SalesPersonID 
inner join Person.Person as p
	on sp.BusinessEntityID = p.BusinessEntityID
order by sp.BusinessEntityID



/*
12- La tabla Sales.SalesOrderHeader contiene un campo foreign Key a la tabla
Sales.CurrencyRate y Purchasing.ShipMethod. escriba un query que una las 3 tablas y
asegurese que contenga todas las filas de la tabla Sales.SalesOrderHeader. Incluya las
columnas CurrencyRateID,AverageRate,SalesOrderID y ShipBase.
*/
select soh.SalesOrderID,
		soh.CurrencyRateID,
		cr.AverageRate,
		sm.ShipBase
from sales.SalesOrderHeader as soh left join  Sales.CurrencyRate as cr
	on soh.CurrencyRateID = cr.CurrencyRateID
left join  Purchasing.ShipMethod as sm
	on soh.ShipMethodID = sm.ShipMethodID


/*
13- Escriba un query que retorne el BusinessEntityID column de la tabla Sales.SalesPerson
junto con todos los productID de la tabla Production.Product.
*/
select sp.BusinessEntityID,
		prod.ProductID
from Sales.SalesPerson as sp inner join Sales.SalesOrderHeader as soh
	on  sp.BusinessEntityID = soh.SalesPersonID 
inner join Sales.SalesOrderDetail as sod
	on soh.SalesOrderID = sod.SalesOrderID
inner join  Production.Product as prod
	on prod.ProductID = sod.ProductID
