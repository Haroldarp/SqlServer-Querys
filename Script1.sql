USE TSQL2012

/*
1- Mostrar todas las ordenes (sales.orders) presentando los campos: OrderId, OrderDate formato
(dd/mm/yyyy), fecha requerida (dd/mm/yyyy), custId. 
*/
select orderid, convert(varchar(15),orderdate,103) [OrderDate], 
convert(varchar(15),requireddate,103) [Fecha requerida], custid 
from Sales.Orders



/*
2- Mostrar todas las órdenes (sales.orders) presentando los campos OrderId, OrderDate formato
(dd/mm/yyyy), fecha requerida (dd/mm/yyyy), custId, cuando (where) el país de la orden sea
Germany.
*/
select orderid, convert(varchar(15),orderdate,103) [OrderDate], 
convert(varchar(15),requireddate,103) [Fecha requerida], custid 
from Sales.Orders
where shipcountry = 'Germany'


/*
3- Realizar una consulta mostrando las ordenes (sales.orders) cuando (where) el campo shipaddress
contenga la palabra Sh. 
*/
select * from Sales.Orders where shipaddress like '%Sh%'


/*
4- Realizar una consulta mostrando las ordenes (sales.orders) cuando el campo shipaddress inicie
con la palabra Sh. 
*/
select * from Sales.Orders where shipaddress like 'Sh%'


/*
5- Realizar una consulta mostrando las órdenes (sales.orders) cuando el freight sea mayor a 30 y
menor 40.
Operador (AND) para poder tener dos filtros en el where. 
*/
select * from Sales.Orders where freight > 30 and freight < 40


/*
6- Realizando una consulta mostrando la cantidad de órdenes (sales.orders) con freight mayor a 40
y shipperId a 1 o 2 o 3 
*/
select * from Sales.Orders where freight > 40 and shipperid in(1,2,3)


/*
7- Realizar una consulta mostrando las órdenes (sales.orders) con freight Mayor a 30 y shipperid 1 y 2, 
*/ 
select * from Sales.Orders where freight > 30 and (shipperid = 1 and shipperid = 2 )


/*
7-1 Mostrar una consulta de ordenes órdenes (sales.orders) con freight menor a 20 y shipperid igual a 3.
(Nota: tienes punto adicional si puedes combinar en 1 solo query las consultas 7 y 7-1). 
*/
select * from Sales.Orders where freight < 20 and shipperid = 3


/*
8- Realizar una consulta de las ordenes tabla Sales.Orders mostrando el OrderId,orderdate formato
(mm/dd/yyyy), fecha actual formato (mm/dd/yyyy) y a su vez un campo donde se visualice la
cantidad de días que paso desde el orderdate hasta la fecha de hoy, y un campo que muestre la
cantidad de días que paso desde el orderDate hasta el shippedDate., Mostrar en un campo lo
siguiente: si el shippedDate es mayor al requiredDate devolver ‘No puntual’ de lo contrario
‘Puntual’. 
*/
select orderid, 
convert(varchar(15),orderdate,101) [OrderDate], 
convert(varchar(15),getdate(),101) [fechaActual],
DATEDIFF(DAY, orderdate, GETDATE()) [diferenciaDiasAhora],
DATEDIFF(DAY, orderdate, shippeddate) [diferenciaDiaShipped],
case when shippeddate > requireddate then 'No puntual' else 'Puntual' end [shippedDate]
from Sales.Orders


/*
9- Realizar una consulta mostrando el orderdate de la tabla sales.orders separado (una columna
para Dias, una para Meses, una para anos) . se debe mostrar en una columna el mes en número y
en otra el mes en texto.
*/
select YEAR(orderdate) [ano], 
MONTH(orderdate) [mes], 
DATENAME(MONTH, orderdate) [mesTexto],
DAY(orderdate) [dia]
from sales.Orders


/*
10-Mostrar la cantidad de sales.customers cuando el contacttitle sea Owner
*/
select count(*)as cantidad from Sales.Customers where contacttitle = 'owner'

/*
11- Mostrar de la tabla sales.customers en una sola columna la unión del contacttitle, y del contact
name el nombre que esta después de la ‘,’. Ejemplo: Contacttitle = Sales Representative,
ContactName=Allen, Michael Resultado= Sales Representative Michael 
*/
select concat(contacttitle, ' ', SUBSTRING(contactname, CHARINDEX(',',contactname)+1, LEN(contactname)))  [Resultado] from Sales.Customers


/*
12- Mostrar de la tabla sales.customers su campo custid,CompanyName sin el texto Customer, y del
campo phone: Reemplazar los puntos por guiones. Con un 1 – delante ejemplo (1- (5) 456-7890), del
campo Fax: si el valor es nulo mostrar el texto ‘N/A’. 
*/
select custid, 
SUBSTRING(companyname, 10, LEN(companyname)) [companyName],
REPLACE(phone,'.','-') [phone],
ISNULL(fax,'N/A') [fax]
from Sales.Customers


/*
13- De la tabla Sales.OrderDetails mostrar los campos, orderid, productId, unitPrice,qty, discount,
Calcular un nuevo campo llamado total que será el resultado de unitPrice*qty – (unitPrice*qty*Discount).
Mostrar un nuevo campo que sea igual a, si Qty < 10 entonces mostrar ‘Producto Agotado’ de lo
contrario ‘Producto en existencia’.
Mostrar un nuevo campo que sea llamado nuevo descuento igual a: si el código del productID <= 51
calcular el nuevo descuento en base al 20% (unitprice * 0.20) de lo contrario 35% (unitprice * 0.35). 
*/
select * , 
(unitprice*qty) - (unitprice*qty*discount) [Total],
case when qty < 10 then 'Producto Agotado' else 'Producto en existencia' end,
case when productid <= 51 then (unitprice*0.20) else (unitprice * 0.35) end [nuevoDescuento]
from Sales.OrderDetails


/*
14- Mostrar la columna productID de Production.Products añadiendo 8 ceros delante, tomando en
cuenta el siguiente patrón vimos en clase:
00000000
00000001
00000010
00000100 
*/
select FORMAT(productid, 'd8') as productID from Production.Products


/*
15- Utilizando la columna shipRegion de la tabla sales.orders mostrar la cantidad de órdenes en la tabla
para cada región. 
*/
select count(shipregion) [cantidadPorRegion]
from Sales.Orders
group by shipregion


/*
16- Utilizando la tabla sales.customers mostrar en dos columnas separadas la parte del nombre dividido
por coma (,) sin espacio en los lados.
*/
select left(contactname, CHARINDEX(',', contactname)-1) [nombre1],
RIGHT(contactname, len(contactname) - CHARINDEX(',', contactname)) [nombre2]
from Sales.Customers