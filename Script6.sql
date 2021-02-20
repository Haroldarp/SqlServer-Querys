use AdventureWorks2012

/*
1- Escriba un subquery que muestre el nombre de los productos y product ID de la tabla
Production.Product, esta tabla debe estar ordenada
*/
select ProductID, Name from Production.Product
order by ProductID


/*
2- Cambie el query anterior para mostrar los productos que no han sido ordenados
*/
select * from Production.Product
where ProductID not in(select distinct sod.ProductID from sales.SalesOrderDetail as sod)


/*
3- Escriba un query usando unión que combine las columnas ModifiedDate de la tabla
Person.Person y el HiredDate de la tabla HumanResources.Employee.
*/
select ModifiedDate from Person.Person
union
select HireDate from HumanResources.Employee


/*
4- Usando una tabla Derivada combine las tablas Sales.SalesOrderHeader a la tabla
Sales.SalesOrderDetails., muestre las columnas SalesOrderID,OrderDate y ProductID.
La tabla Sales.SalesOrderDetail debe estar dentro de la tabla derivada.
*/
select * from (select soh.SalesOrderID,
		soh.OrderDate,
		sod.ProductID
from sales.SalesOrderHeader as soh inner join sales.SalesOrderDetail as sod
	on soh.SalesOrderID = sod.SalesOrderID) as derivada



/*
5- Reescriba el query anterior usando un CTE.
*/
with cte as 
(
select soh.SalesOrderID,
		soh.OrderDate,
		sod.ProductID
from sales.SalesOrderHeader as soh inner join sales.SalesOrderDetail as sod
	on soh.SalesOrderID = sod.SalesOrderID
)

select * from cte


/*
6- Escriba un query que muestre todos los clientes junto con las ordenes creadas en el
2009. use un cte y incluya el CustomerID, SalesOrderID y orderDate en el resultado.
*/
with cte as 
(
	select c.CustomerID ,sh.SalesOrderID , sh.OrderDate
	from Person.Person as p inner join  Sales.Customer as c
		on p.BusinessEntityID = c.PersonID
	inner join Sales.SalesOrderHeader as sh
		on c.CustomerID = sh.CustomerID
	where year(sh.OrderDate) = '2009'
)

select * from cte

