use AdventureWorks2012

/*
1- El equipo de recursos humanos nos ha pedido identificar cuales empleados poseen mayor
salida o ausencia en la empresa., para poder identificarlo un empleado debe tener el campo
SickLeaveHours Mayor a 68 y VacationHours mayor a 98. Estas columnas se encuentran en
la tabla Employee del esquema HumanResources.
*/
select rowguid, BusinessEntityID, SickLeaveHours, VacationHours from HumanResources.Employee
where SickLeaveHours > 68 and VacationHours > 98


/*
2- Su manager le ha pedido que está interesado en analizar todas las columnas de ciertas
órdenes en específico, dado esto ella indica que está interesada en ordenes con el
campo SalesOrderId entre 43702 y 43712.
*/
select * from Sales.SalesOrderHeader 
where SalesOrderID between 43702 and 43712


/*
3 - Porque se debe especificar los nombres de las columnas y no utilizar asterisco cuando
escribimos nuestra lista de select, indique 2 motivos.

Respuesta: 
No traer informacion que sea innecesaria
evitar problemas a las hora de usar joins (traer tablas con el mismo valor)
*/


/*
4- Crea un query que muestre a todos los empleados de la tabla Employees que tengan el titulo de
Research and Development Engineer., mostrando las columnas
BusinessEntityID,LoginID,JobTitle
*/
select BusinessEntityID, LoginID, JobTitle from HumanResources.Employee
where JobTitle = 'Research and Development Engineer'


/*
5- Mostrar en un query a las personas de la tabla Person.Person cuando su Middle name sea
J., Mostrar el primer nombre concatenado con el last y middle name. Mostrar su ID
number.
*/
select BusinessEntityID, 
CONCAT(FirstName, ' ', MiddleName, '. ', LastName) [FullName] 
from Person.Person
where MiddleName = 'J'


/*
6- Mostrar todas las ordenes de la tabla Production.ProductCostHistory cuando la fecha de
modificación (modifiedDate) sea Mayo 16 del 2013
*/
select * from Production.ProductCostHistory
where ModifiedDate = '2013-05-16'


/*
7- Crea un query que muestre a todos los empleados de la tabla Employees que no posean ningún
titulo., mostrando las columnas BusinessEntityID,LoginID,JobTitle
*/
select BusinessEntityID, LoginID, JobTitle from HumanResources.Employee
where JobTitle is null


/*
8- Crea un query que muestre a todos los empleados de la tabla Employees que no posean el
titulo Research and Development Engineer., mostrando las columnas
BusinessEntityID,LoginID,JobTitle
*/
select BusinessEntityID, LoginID, JobTitle from HumanResources.Employee
where JobTitle != 'Research and Development Engineer'


/*
9- Mostrar todas las personas de la tabla Person.Person cuando la fecha de modificación sea
luego de 1 de febrero del 2009.
*/
select * from Person.Person
where ModifiedDate > '2009-02-1'


/*
10- Mostrar todas las personas de la tabla Person.Person cuando la fecha de modificación no
sea 1 de febrero del 2009.
*/
select * from Person.Person
where ModifiedDate != '2009-02-1'


/*
11- Mostrar el top de las 5 personas que fueron modificadas durante el 2009.
*/
select top 5 * from Person.Person
where YEAR(ModifiedDate) = 2009
order by ModifiedDate


/*
12- Mostrar el top de 5 personas que no fueron modificadas en el 2009.
*/
select top 5 * from Person.Person
where YEAR(ModifiedDate) != 2009
order by BusinessEntityID


/*
13- Crear un query que muestre el Id del producto y nombre para cada producto de la tabla
Production.Product que el nombre inicie con la palabra Chain.
*/
select ProductID, Name from Production.Product
where Name like 'Chain%'


/*
14- Cree un query que despliegue los productos que contengan la palabra Helmet en su nombre.
*/
select * from Production.Product
where Name like '%Helmet%'


/*
15- Modifique el query anterior para que se muestren los productos que no poseen la palabra
helmet en su nombre.
*/
select * from Production.Product
where Name not like '%Helmet%'


/*
16- Cree un query mostrando el Id, first Name, middle name, y last Name de la table Person.Person
cuando solo posea la literal E o B en la columna middle Name.
*/
select BusinessEntityID, FirstName, MiddleName, LastName 
from Person.Person where MiddleName in('E','B')



/*
17- Crear un nuevo query mostrando el OrderId, Order Date, y total due de la tabla
Sales.SalesOrderHeader, mostrando solo las ordenes creadas durante el mes de septiembre del
2011 y que el total due sea mayor o igual a 1000.
*/
select SalesOrderID, OrderDate, TotalDue
from Sales.SalesOrderHeader
where YEAR(OrderDate) = 2011 and MONTH(OrderDate) = 8
and TotalDue >=1000


/*
18- Modificar el query anterior para mostrar solo las ordenes creadas durante los días 1,2,3 de
septiembre 2019., usted debe plantear 3 queries diferentes para lograr la misma solución.
*/
select SalesOrderID, OrderDate, TotalDue
from Sales.SalesOrderHeader
where YEAR(OrderDate) = 2011 and MONTH(OrderDate) = 8 
and DAY(OrderDate) in(1,2,3)
and TotalDue >=1000

select SalesOrderID, OrderDate, TotalDue
from Sales.SalesOrderHeader
where (OrderDate = '2011-8-1' or 
OrderDate = '2011-8-2' or 
OrderDate = '2011-8-3')
and TotalDue >=1000

select SalesOrderID, OrderDate, TotalDue
from Sales.SalesOrderHeader
where OrderDate in( '2011-8-1', '2011-8-2','2011-8-3')
and TotalDue >=1000


/*
19- Usted debe mostrar todas las ordenes que su total due sea mayor a 1000 cuando el
salespersonId sea 279 o el territorio sea el 6
*/
select * from Sales.SalesOrderHeader
where TotalDue > 1000 and
(SalesPersonID = 279 or TerritoryID = 6)


/*
20- Cambia el query anterior para también incluir el territorio 4
*/
select * from Sales.SalesOrderHeader
where TotalDue > 1000 and
(SalesPersonID = 279 or TerritoryID in(6,4))


/*
21- Explique cuando hace sentido usar la clausula IN

Respuesta:
cuando nos vemos en una situacion en la que se podrian utilizar multiples or,
osea, cuando se quiere filtrar por multiples opciones una misma columna
*/


/*
22- Escriba un query que muestre de la tabla Production.Products los campos productId, Name y
color cuando no posean color asignado.
*/
select ProductID, Name, Color 
from Production.Product
where Color is null


/*
23- Modifique el query anterior solo mostrando los productos cuando el color no sea azul.
*/
select ProductID, Name, Color 
from Production.Product
where Color != 'blue'


/*
24- Cree un query mostrando ProductId,Name,Style,Size y color de la tabla Products cuando al
menos una de las columnas Style,Size o color tenga valor
*/
select ProductID, Name, Style, Size,Color 
from Production.Product
where Color is not null 
or Style is not null
or Size is not null


/*
25- Cree un query que retorne el BusinessEntityId y nombre de la tabla Person.Person ordenando
los resultados por LastName,FirstName y MiddleName.
*/
select BusinessEntityID, CONCAT(FirstName, ' ', MiddleName, ' ', LastName) [FullName] 
from Person.Person
order by LastName, FirstName, MiddleName



/*
26- Modifica el query anterior para que la data se devuelva en el orden opuesto.
*/
select BusinessEntityID, CONCAT(FirstName, ' ', MiddleName, ' ', LastName) [FullName] 
from Person.Person
order by  MiddleName, FirstName, LastName



/*
27- Escriba un query que muestre de la tabla Production.Products los campos productId, Name y
color si no posee color mostrar ‘N/A’ 
*/
select ProductID, Name, ISNULL(Color, 'N/A') [Color]
from Production.Product


/*
28- Usando la tabla Sales.SpecialOffer se debe mostrar la diferencia entre MinQty y MaxQty en
conjunto a las columnas SpecialOfferId y description.
*/
select (isnull(MaxQty, 0) - isnull(MinQty, 0)) [diferenciaQty], 
SpecialOfferID, Description 
from Sales.SpecialOffer


/*
29- Usando la tabla sales.SpecialOffer Multiplicar los valores de MinQty por DiscountPCT y mostrar
en conjunto a las columnas SpecialOfferId y description.
*/
select MinQty * DiscountPct, SpecialOfferID, Description
from Sales.SpecialOffer


/*
30- Usando la tabla sales.SpecialOffer Multiplicar los valores de maxQty por DiscountPCT si el
maxqty es null entonces sustituir por el valor 10 y mostrar en conjunto a las columnas
SpecialOfferId y description.
*/
select isnull(MaxQty, 10) * DiscountPct, SpecialOfferID, Description
from Sales.SpecialOffer
