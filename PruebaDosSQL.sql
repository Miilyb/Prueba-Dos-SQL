#Prueba 2 mysql - Caso Practico
# tengo que tener si o si : Schema
#							Minimo 5 tablas (OK)
#							Minimo 1 tabla relacional (OK)
#							Minimo 5 productos (OK)
#							Minimo 4 tipos de productos (OK)
#							2 consultas basicas obteniendo dato de tablas (ok)
#							2 consulta con join con almmenos 2 tablas

# vende distintos productos (por tanto tengo que tener una tabla de productos)
# Tiene Dieferentes proveedores ( por tanto existe una tabla de Proveedores)
# Me "obliga" a hacer otra tabla =  tipos de productos
# necesita un informe = anual _ ganancia y venta de productos, por tanto debo de saber en algun punto
#       cuanto le cuesta la compra de los productos y a cuanto los vende y asi determinar la ganancia
# relaciones posibles:  producto_provedor, minimarket_proveedor, producto_minimarket,
#                       producto_venta


# ---------------------- Minimarket de Don Jose------------------------------------------- 

# ------- Creamos lo esencial el esquema mas le indicamos que use tal esquema-------------
CREATE SCHEMA pruebaDosSql;
USE pruebaDosSql;
#-----------------------------------------------------------------------------------------

#-------- Creamos las tablas y tablas relacionales ---------------------------------------

CREATE TABLE TipoProducto (
tipoProducto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreTipoProducto VARCHAR (30)
);

CREATE TABLE Producto (
producto_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreProducto VARCHAR (30),
costoDeCompra INTEGER,
PrecioDeVenta INTEGER,
tipoProducto_id INTEGER,
FOREIGN KEY (tipoProducto_id) REFERENCES TipoProducto (tipoProducto_id)
);

CREATE TABLE Proveedor (
proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombre VARCHAR (50),
rol VARCHAR (50),
correo VARCHAR (50)
);

CREATE TABLE ProductoProveedor (
producto_id INTEGER,
proveedor_id INTEGER,
FOREIGN KEY (producto_id) REFERENCES Producto (producto_id),
FOREIGN KEY (proveedor_id) REFERENCES Proveedor (proveedor_id)
);

CREATE TABLE Venta (
venta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
diaDeVenta DATE
);

CREATE TABLE ProductoVenta (
productoVenta_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
cantidadDeProducto INTEGER,
producto_id INTEGER,
venta_id INTEGER,
FOREIGN KEY (producto_id) REFERENCES Producto (producto_id),
FOREIGN KEY (venta_id) REFERENCES Venta (venta_id)
);

#----------Ingresar datos a las tablas y consultas basicas -------------------------------------

INSERT INTO TipoProducto (nombreTipoProducto) VALUES ("No peresibles"),
("Cuidado Personal"),
("Limpieza"),
("Linea Blanca"), 
("Libreria");

SELECT * FROM TipoProducto; 

INSERT INTO Producto (nombreProducto, costoDeCompra, PrecioDeVenta, tipoProducto_id) VALUES
("Fideos", 750, 900, 1),
("Desodorante", 1200, 1500, 2),
("Poet", 800, 1200, 3),
("Lavadora", 280000, 300000, 4),
("Carton Piedra", 700, 950, 5);

SELECT * FROM Producto;

INSERT INTO Proveedor (nombre, rol, correo) VALUES ("C&F", "6984752-5", "C&F@gmail.com"),
("G&D", "5769428-3","G&D@gmail.com"),
("M&H", "9857456-0","M&H@gmail.com"),
("N&C", "3598745-2","N&C@gmail.com"),
("C&A", "4589652-9","C&A@gmail.com");

SELECT * FROM Proveedor;

INSERT INTO ProductoProveedor (producto_id, proveedor_id ) VALUES (1,5) , (2,4) , (3,3) , (4,2), (5,1);

SELECT * FROM ProductoProveedor;

INSERT INTO Venta (diaDeVenta ) VALUES ('2023-03-15'), 
('2023-03-16'),
('2023-03-17'),
('2023-03-18'),
('2023-03-19');

SELECT * FROM Venta;

INSERT INTO ProductoVenta (cantidadDeProducto, producto_id, venta_id ) VALUES
(4,1,1),(2,2,2),(6,3,3),(1,4,4),(3,5,5);

SELECT * FROM ProductoVenta;

#---------------------------- JOIN-----------------------------------------------------

SELECT Producto.nombreProducto, Producto.costoDeCompra, Producto.PrecioDeVenta, ProductoVenta.cantidadDeProducto
FROM Producto LEFT JOIN ProductoVenta ON Producto.producto_id = ProductoVenta.productoVenta_id;

SELECT Producto.nombreProducto, Producto.PrecioDeVenta, Producto.costoDeCompra, ProductoVenta.cantidadDeProducto
FROM Producto RIGHT JOIN ProductoVenta ON Producto.producto_id = ProductoVenta.productoVenta_id;

SELECT Producto.nombreProducto, Producto.PrecioDeVenta, Producto.costoDeCompra, ProductoVenta.cantidadDeProducto
FROM Producto INNER JOIN ProductoVenta ON Producto.producto_id = ProductoVenta.productoVenta_id;

SELECT TipoProducto.nombreTipoProducto, Producto.nombreProducto, Producto.costoDeCompra, Producto.PrecioDeVenta
FROM TipoProducto LEFT JOIN Producto ON TipoProducto.tipoProducto_id = Producto.producto_id;
#--------------------------------------------------------------------------------------------------
# Mi idea era de alguna forma poder restar y luego multiplicar los datos para que me pueda dar la ganancia
# De la tabla Producto usar los datos de costoDeCompra , PrecioDeVenta y de la tabla Producto venta usar cantidadDeProducto
# y asi la Ganancia = (PrecioDeVenta - costoDeCompra)* cantidadDeProducto, Pero por esta vez no supe hacerlo :C 
# Pero como se que Don Jose con tantos años en el rubro ya sabe como calcular la ganancia jaja 
# Muchas gracias por todo <3 
