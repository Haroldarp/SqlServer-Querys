use TSQL2012

/*
1- Realizar una consulta a la tabla orders mostrando el orderid,custid,empid, orderdate, requireddate y shippeddate.
adicional a esto usted debe hacer lo necesario para poder mostrar lo siguiente:
	
	- Si la diferencia de días que existe entre el orderdate y required date es igual a 28 o 29 entonces mostrar 'SLA DE
3 SEMANAS', si es igual a 14 o 15 mostrar 'SLA 2 SEMANAS'.

	- Si es igual a 42 mostrar 'SLA DE 4 SEMANAS' y si no cumple con ninguna de las anteriores mostrar 'N/A'
*/
select orderid, custid, empid, orderdate, requireddate, shippeddate,
case 
when DATEDIFF(DAY, orderdate, requireddate) in(14,15) then 'SLA 2 SEMANAS'
when DATEDIFF(DAY, orderdate, requireddate) in(28,29) then 'SLA 3 SEMANAS'
when DATEDIFF(DAY, orderdate, requireddate) = 42 then 'SLA 4 SEMANAS'
else 'N/A' end diff
from Sales.Orders



/*
2- Realizar una consulta mostrando los productos y su respectiva categoría (categoryName)
*/
select p.productid, 
	p.productname, 
	p.supplierid, 
	c.categoryname, 
	p.unitprice, 
	p.discontinued
from Production.Products as p 
inner join 
Production.Categories as c
on p.categoryid = c.categoryid


/*
3- mostrar el top de los 15 últimos productos creados mostrando el orderDate, requireddate y shippeddate utilizando un
formato de fecha distinto para cada uno
*/
select top 15 
CONVERT(varchar(15), orderdate, 101),
CONVERT(varchar(15), requireddate, 10),
CONVERT(varchar(15), shippeddate, 106)
from Sales.Orders
order by orderid desc


/*
4- tomando en cuenta que tenemos la tabla sales.orders y sales.orderdetails usted debe hacer lo necesario para poder
mostrar el total de las ventas realizadas, agrupándolas de la siguiente forma:

AnoOrden, MesOrden, Total
*/
select 
	DATEPART(year, orderdate) [Año],
	DATEPART(month, orderdate) [Mes],
	convert(money, sum(( od.unitprice*od.qty) - (od.unitprice*od.qty*od.discount)) ) [TotalVentas]
from Sales.Orders as o inner join Sales.OrderDetails as od
	on o.orderid = od.orderid
group by DATEPART(year, orderdate), DATEPART(month, orderdate)
order by Año, Mes



/*
5- Dado los siguientes querys usted debe ejecutar cada uno si existe alguna diferencia entre los resultados debe
explicarla:

Diferencias
	
	- El orden del primer query esta organizado de forma descendiente y el segundo de forma ascendente
	- El primer query usa left join por lo tanto si no hay un campo que relacione el customer con una orden este no aparece
	- El segundo query usa right join por lo tanto el el registro del customer aparece sin necesidad de estar relacionado don una orden
*/
select Emp.empid,
	Emp.firstname+' '+Emp.lastname as Empleado,
	cust.contactname,
	o.orderid,
	O.orderdate
from hr.Employees Emp inner join sales.Orders O
	on emp.empid = o.empid
left join sales.Customers Cust
	on Cust.custid = o.custid
	order by empid desc


select Emp.empid,
	Emp.firstname+' '+Emp.lastname as Empleado,
	cust.contactname,
	o.orderid,
	O.orderdate
from hr.Employees Emp inner join sales.Orders O
	on emp.empid = o.empid
right join sales.Customers Cust
	on o.custid = Cust.custid
	order by empid asc



/*
5- Dada la tabla stats.score realizar lo siguiente:
a-Mostrar cada examen.
b-Mostrar la cantidad de estudiantes que hay por cada examen.
c-Mostrar la cantidad de estudiantes que aprobaron el examen. Logica:(si el score es mayor o igual a 70 )
*/
--A
select * from Stats.Scores

--B
select testid , count(studentid) [CantidadEstudiantes] from Stats.Scores
group by testid

--C
select testid , count(studentid) [CantidadEstudiantesAprobados] from Stats.Scores
where score >= 70 
group by testid



/*
6- Mostrar la cantidad de meses que han pasado de enero a la fecha
*/
select DATEDIFF(MONTH, '2020-01-1',GETDATE()) [DiferenciaMeses]



/*
8- Mostrar en un resultado los campos empid, FullName empleado (HR.EMPLOYEES) mostrando la primera y ultima
orden este empleado creo. Los empleados no deben salir duplicados.
*/
select 
	e.empid, 
	CONCAT(e.firstname, ' ', e.lastname) [FullName],
	min(o.orderdate) [PrimeraOrden],
	max(o.orderdate) [UltimaOrden]
from HR.Employees as e inner join Sales.Orders as o
	on e.empid = o.empid
group by e.empid, CONCAT(e.firstname, ' ', e.lastname) 
order by e.empid


/*
9- Mostrar en un resultado los campos empid, FullName empleado (HR.EMPLOYEES) mostrando el producto con el
precio mínimo y el producto con el precio máximo para la primera orden el empleado creo.
*/
select distinct
	e.empid,
	CONCAT(e.firstname, ' ', e.lastname) [FullName],
	 o.orderdate [PrimeraOrden],
	 od.productid,
	od.unitprice
from HR.Employees as e inner join Sales.Orders as o
	on e.empid = o.empid
	and o.orderdate = (select min(z.orderdate) from Sales.Orders as z
							where z.empid = o.empid)
inner join Sales.OrderDetails as od
	on o.orderid = od.orderid
	and (
		od.unitprice = (select MAX(y.unitprice) from Sales.OrderDetails as y
							where y.orderid = od.orderid)
		or od.unitprice = (select MIN(y.unitprice) from Sales.OrderDetails as y
							where y.orderid = od.orderid)
		)
order by e.empid, od.unitprice




/*
10- Mostrar los suplidores (Production.suppliers) cuando el campo contacttitle Contenga la literal
'Manag'
*/
select * from Production.Suppliers
where contacttitle like '%Manag%'


/*
11- tomando la tabla suppliers nos fijamos el companyName viene bajo el patron supplier Codigo, tomando esto en
cuenta separar el companany name mostrando en una columna el Supplier y en otra el literal restante sin espacio.
*/
select 
left(companyname ,CHARINDEX(' ',companyname)-1),
SUBSTRING(companyname, CHARINDEX(' ',companyname)+1, len(companyname))
from Production.Suppliers


/*
12- tomando la tabla products y Suppliers mostrar los campos supplierid, contactname, el producto con el precio mayor
para cada suplidor, la cantidad de productos total de ese suplidor y la cantidad de productos que poseen orden creada.
*/
select s.supplierid,
		s.contactname,
		max(p.unitprice) [PrecioMayor],
		count(distinct p.productid) [CantidadProductos],
		count(od.productid) [CantidadOrdenes]
from Production.Suppliers as s inner join Production.Products as p
	on s.supplierid = p.supplierid
left join Sales.OrderDetails as od
	on p.productid = od.productid
	group by s.supplierid, s.contactname
	order by s.supplierid