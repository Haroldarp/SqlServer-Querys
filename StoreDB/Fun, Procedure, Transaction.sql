USE ECommerce


/*1- Ingresar nuevos productos*/
CREATE PROCEDURE InsertProduct(
@ProductName nvarchar(50),
@Quantity int,
@UnitPrice money,
@Description nvarchar(200),
@CategoryId int
)
AS
BEGIN
	INSERT INTO Product VALUES (@ProductName, @Quantity, @UnitPrice, @Description, @CategoryId)
END

exec InsertProduct 'product', 5, 15.22, 'des', 1


/*2- Eliminar Productos*/
CREATE PROCEDURE DeleteProduct(
@ProductId INT
)
AS 
BEGIN 
	DELETE FROM Product WHERE ProductId= @ProductId
END

exec DeleteProduct 41




/*3- Actualizar Productos*/
CREATE PROCEDURE UpdateProduct(
@ProductId	INT,
@ProductName nvarchar(50) = NULL,
@Quantity int = NULL,
@UnitPrice money = NULL,
@Description nvarchar(200) = NULL,
@CategoryId int = NULL
)
AS
BEGIN
	UPDATE Product 
		SET ProductName = ISNULL(@ProductName, ProductName),
			Quantity = ISNULL(@Quantity, Quantity),
			UnitPrice = ISNULL(@UnitPrice, UnitPrice),
			Description = ISNULL(@Description, Description),
			CategoryId = ISNULL(@CategoryId, CategoryId)
		WHERE ProductId = @ProductId
END

exec UpdateProduct 1, 'update'





/*
4- Registrar compras teniendo en cuenta los impuestos (Tienen que separar el
neto de los impuestos. Si revisan cualquier factura se darán cuenta de que
siempre se muestra separado).
Nota: No debe aceptar datos erróneos ni vacíos, no se pueden procesar
compras si no hay mercancía suficiente (Por ejemplo: Un cliente puede pedir 3
correas pero solo hay 1 disponible, debe enviar un mensaje para notificarle al
cliente).
*/
CREATE PROCEDURE RegistrarCompra(
@ClientId INT,
@ProductId INT,
@Quantity INT,
@SalesHId INT,
@RandDate date = NULL
)
AS
BEGIN 
BEGIN TRANSACTION

	IF NOT EXISTS (SELECT * FROM SalesHeader WHERE SalesHId = @SalesHId)
	BEGIN
		INSERT INTO SalesHeader (ClientId, SalesDate) VALUES (@ClientId,ISNULL(@RandDate,GETDATE()))
	END
	
	DECLARE @QuantityInStock INT
	SET @QuantityInStock = (SELECT Quantity FROM Product WHERE ProductId = @ProductId)

	IF (@QuantityInStock >= @Quantity)
	BEGIN

		DECLARE @UnitPrice MONEY, @SubTotal MONEY, @ITBIS MONEY, @TotalBefore MONEY, @TotalAfter MONEY

		SET @UnitPrice = (select UnitPrice from Product where ProductId = @productId)
		SET @SubTotal = @Quantity*@UnitPrice
		SET @ITBIS = ROUND((@SubTotal*0.18),2) 

		INSERT INTO SalesDetails VALUES (@SalesHId, @ProductId, @Quantity, @UnitPrice,@ITBIS)

		UPDATE Product SET Quantity = Quantity - @Quantity WHERE ProductId = @ProductId


		SET @TotalBefore = (SELECT Total FROM SalesHeader WHERE SalesHId = @SalesHId)

		UPDATE SalesHeader SET 
			SubTotal = SubTotal + @SubTotal,
			ITBIS = ITBIS + @ITBIS,
			Total = Total + @SubTotal + @ITBIS
		WHERE SalesHId = @SalesHId

		SET @TotalAfter = (SELECT Total FROM SalesHeader WHERE SalesHId = @SalesHId)

		UPDATE Client SET Credito = Credito - FLOOR(@TotalBefore/100) + FLOOR(@TotalAfter/100) 
			WHERE ClientId = @ClientId

		COMMIT
		
	END
	ELSE
	BEGIN
		PRINT 'NO HAY PRODUCTO SUFICIENTE EN EL INVENTARIO, SOLO HAY ' + CONVERT(VARCHAR, @QuantityInStock)
		ROLLBACK
	END
END

exec RegistrarCompra 1, 1, 1, 1






/*5- Mostrar los 5 productos más vendidos*/
CREATE PROCEDURE Top5ProductsSold
AS
BEGIN
	select TOP 5 p.ProductId, p.ProductName, sum(sd.Quantity) as Cantidad from salesDetails as sd
		inner join Product as p on sd.ProductId = p.ProductId
		group by p.ProductId, p.ProductName
		order by Cantidad DESC
END

exec Top5ProductsSold





 /*6- Mostrar los productos más vendidos para un cliente especifico*/
CREATE PROCEDURE Top5ProductsSoldByClient(
@ClientId INT
)
AS
BEGIN
	select TOP 5 p.ProductId, p.ProductName, sum(sd.Quantity) as Cantidad from salesDetails as sd
		inner join Product as p on sd.ProductId = p.ProductId
		inner join SalesHeader as sh on sh.SalesHId = sd.SalesHId
		where sh.ClientId = @ClientId
		group by p.ProductId, p.ProductName
		order by Cantidad DESC
		
END

exec Top5ProductsSoldByClient 10




/*7- Por cada 100 pesos de compra, a los clientes se le da un crédito en la tienda.*/
CREATE FUNCTION CalcPuntos(
@Monto MONEY
)
RETURNS INT
AS
BEGIN
	DECLARE @valorDiv INT = 100
	DECLARE @resultado INT
	SET @resultado = FLOOR( @monto / @valordiv)
	IF(@resultado <= 0)
	BEGIN
		set	@resultado = 0
	END

	RETURN @resultado
END

select dbo.CalcPuntos(199) as Puntos




/*8- Obtener el cliente con más puntos en la tienda para que pueda obtener un descuento.*/
CREATE PROCEDURE getClientMostPoints
AS
BEGIN
	SELECT * FROM Client WHERE Credito = (SELECT MAX(Credito) FROM Client)
END

exec getClientMostPoints





/*9- Actualizar clientes*/
CREATE PROCEDURE UpdateClient(
@ClientId int,
@FirstName nvarchar(50) = NULL,
@LastName nvarchar(50) = NULL,
@Phone varchar(10) = NULL,
@Address nvarchar(200) = NULL,
@Mail nvarchar(50) = NULL,
@Sex int = NULL,
@Birthdate date = NULL,
@Credito int = null
)
AS
BEGIN
	UPDATE Client 
		SET FirstName = ISNULL(@FirstName, FirstName),
			LastName = ISNULL(@LastName, LastName),
			Phone = ISNULL(@Phone, Phone),
			Address = ISNULL(@Address, Address),
			Mail = ISNULL(@Mail, Mail),
			Credito = ISNULL(@Credito,Credito),
			Sex = ISNULL(@Sex, Sex),
			Birthdate = ISNULL(@Birthdate, Birthdate)
		where ClientId = @ClientId
END

exec UpdateClient 1, 'Update'




/* 
10-Debe registrar al menos 500 ventas de productos para que pueda
realizar un ranking utilizando las funciones pertinentes donde se muestren
un ranking de las categorías más vendidas, y un ranking de los productos
más vendidos por categorías.
*/
CREATE PROCEDURE AddSales(
@Quantity INT
)
AS
BEGIN
	DECLARE @count1 INT
	DECLARE @count2 INT
	DECLARE @RandProductId INT
	DECLARE @RandQuantity INT
	DECLARE @RandClientId INT
	DECLARE @SalesHId INT
	DECLARE @RandDate DATE

	set @count1 = 1
	set @SalesHId = IDENT_CURRENT('SalesHeader') + 1

	IF(@SalesHId = 2)
	BEGIN
		set @SalesHId = 1
	END

	WHILE (@count1 <= @Quantity)
	BEGIN
		set @count2 = 1
		set @RandClientId = FLOOR(RAND()*20)+1
			
			WHILE (@count2 <= FLOOR(RAND()*(10))+1)
			BEGIN
				set @RandProductId = FLOOR(RAND()*(40))+1
				set @RandQuantity = FLOOR(RAND()*(3))+1
				set @RandDate = DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 365), '2020-01-01')
				exec RegistrarCompra @RandClientId, @RandProductId, @RandQuantity, @SalesHId, @RandDate
				SET @count2  = @count2  + 1
			END
			SET @count1  = @count1  + 1
			SET @SalesHId  = @SalesHId  + 1
	END
END

exec AddSales 500



CREATE PROCEDURE RankingCategory
AS
BEGIN
	select pc.CategoryId, pc.CategoryName, sum(sd.Quantity) as Cantidad from salesDetails as sd
		inner join Product as p on sd.ProductId = p.ProductId
		inner join ProductCategory as pc on p.CategoryId = pc.CategoryId
		group by pc.CategoryId, pc.CategoryName
		order by Cantidad DESC
END

exec RankingCategory
