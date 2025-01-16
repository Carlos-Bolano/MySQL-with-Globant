-- Actividad: Mi primera tabla
-- Crear la base de datos mi_bd
CREATE DATABASE mi_bd;

-- Crear la base de datos mi_bd_2 y eliminarla
CREATE DATABASE mi_bd_2;
DROP DATABASE mi_bd_2;

-- Usar la base de datos mi_bd
USE mi_bd;

-- Actividad: Tabla Empleados
-- Crear tabla "empleados"
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    edad INT,
    salario DECIMAL(10, 2),
    fecha_contratacion DATE
);

-- Modificar la tabla "empleados"
-- Hacer que la columna "edad" no permita valores nulos
ALTER TABLE empleados MODIFY edad INT NOT NULL;

-- Establecer un valor predeterminado de 0 para la columna "salario"
ALTER TABLE empleados MODIFY salario DECIMAL(10, 2) DEFAULT 0;

-- Agregar columna "departamento"
ALTER TABLE empleados ADD departamento VARCHAR(50);

-- Agregar columna "correo_electronico"
ALTER TABLE empleados ADD correo_electronico VARCHAR(100);

-- Eliminar la columna "fecha_contratacion"
ALTER TABLE empleados DROP COLUMN fecha_contratacion;


-- Volver a agregar la columna "fecha_contratacion" con valor predeterminado de la fecha actual
-- En caso tengas problemas con el current_date o el now() usa 
ALTER TABLE empleados ADD fecha_contratacion DATE DEFAULT (CURDATE());
-- ALTER TABLE empleados ADD fecha_contratacion DATE DEFAULT CURRENT_DATE;

-- Crear tabla "departamentos"
CREATE TABLE departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Agregar columna "departamento_id" en la tabla "empleados"
ALTER TABLE empleados ADD departamento_id INT;

-- Establecer una restricción de clave foránea en la columna "departamento_id"
ALTER TABLE empleados ADD CONSTRAINT fk_departamento FOREIGN KEY (departamento_id) REFERENCES departamentos(id);

-- Eliminar la columna "departamento" de la tabla "empleados"
ALTER TABLE empleados DROP COLUMN departamento;

-- Actividad: Aplicando DML
-- Insertar datos en la tabla "departamentos"
INSERT INTO departamentos (nombre) VALUES ('Ventas');
INSERT INTO departamentos (nombre) VALUES ('Recursos Humanos');

-- Insertar datos en la tabla "empleados"
INSERT INTO empleados (nombre, apellido, edad, salario, correo_electronico, departamento_id) VALUES
('Ana', 'Rodríguez', 28, 3000.00, 'anarodriguez@mail.com', 1),
('Carlos', 'López', 32, 3200.50, 'carloslopez@mail.com', 2),
('Laura', 'Pérez', 26, 2800.75, 'lauraperez@mail.com', 1),
('Martín', 'González', 30, 3100.25, 'martingonzalez@mail.com', 2);

-- Actualizar el salario del empleado "Ana" en un 10%
UPDATE empleados
SET salario = salario * 1.10
WHERE nombre = 'Ana';

-- Crear un nuevo departamento "Contabilidad"
INSERT INTO departamentos (nombre) VALUES ('Contabilidad');

-- Cambiar el departamento del empleado "Carlos" a "Contabilidad"
UPDATE empleados
SET departamento_id = (SELECT id FROM departamentos WHERE nombre = 'Contabilidad')
WHERE nombre = 'Carlos';

-- Eliminar al empleado con nombre "Laura"
DELETE FROM empleados
WHERE nombre = 'Laura';


-- Deshabilitar el modo seguro de actualizaciones si es necesario
-- SET SQL_SAFE_UPDATES = 0;

-- Consultas para verificar los datos
-- Consulta de la tabla "empleados"
SELECT id, nombre, apellido, edad, salario, correo_electronico, fecha_contratacion, departamento_id
FROM empleados;

-- Consulta de la tabla "departamentos"
SELECT id, nombre
FROM departamentos;

-- Actividad: Práctica avanzada
-- Crear tabla "clientes"
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR(100) NOT NULL
);

-- Crear tabla "productos"
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Crear tabla "ventas"
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT NOT NULL,
    cliente_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    monto_total DECIMAL(10, 2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    empleado_id INT NOT NULL,
    CONSTRAINT fk_producto FOREIGN KEY (producto_id) REFERENCES productos(id),
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    CONSTRAINT fk_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(id)
);

-- Insertar datos iniciales
INSERT INTO clientes (nombre, direccion) VALUES ('Juan Pérez', 'Libertad 3215, Mar del Plata');
INSERT INTO productos (nombre, precio) VALUES ('Laptop', 1200.00);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) VALUES
(1, 1, 2, 1200.00, 1);

-- Consultar datos de la tabla "ventas"
SELECT id, producto_id, cliente_id, cantidad, precio_unitario, monto_total, empleado_id
FROM ventas;

-- Ejercicios DML adicionales
INSERT INTO productos (nombre, precio) VALUES ('Teléfono móvil', 450.00);
INSERT INTO clientes (nombre, direccion) VALUES ('María García', 'Constitución 456, Luján');

-- Modificar la columna correo_electronico para generarse automáticamente
ALTER TABLE empleados
MODIFY correo_electronico VARCHAR(100) GENERATED ALWAYS AS (CONCAT(nombre, apellido, '@mail.com')) STORED;

-- Insertar nuevos empleados
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Luis', 'Fernández', 28, 2800.00, 1);
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Marta', 'Ramírez', 32, 3100.00, 1);
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id) VALUES ('Lorena', 'Guzmán', 26, 2600.00, 1);

-- Actualizar datos
UPDATE productos SET precio = 1350.00 WHERE nombre = 'Laptop';
UPDATE clientes SET direccion = 'Alberti 1789, Mar del Plata' WHERE nombre = 'Juan Pérez';
UPDATE empleados SET salario = salario * 1.05;
UPDATE productos SET precio = 480.00 WHERE nombre = 'Teléfono móvil';
UPDATE clientes SET direccion = 'Avenida 789, Ciudad del Este' WHERE nombre = 'María García';
UPDATE empleados SET salario = salario * 1.07 WHERE departamento_id = (SELECT id FROM departamentos WHERE nombre = 'Ventas');

-- Insertar más datos
INSERT INTO productos (nombre, precio) VALUES ('Tablet', 350.00);
INSERT INTO productos (nombre, precio) VALUES ('Impresora', 280.00);
INSERT INTO clientes (nombre, direccion) VALUES ('Ana López', 'Beltrán 1452, Godoy Cruz');
INSERT INTO clientes (nombre, direccion) VALUES ('Carlos Sánchez', 'Saavedra 206, Las Heras');

-- consultar datos en la tabla ventas, empleados, clientes y productos para comparar con los la plataforma
SELECT * from ventas;
SELECT * from empleados;
SELECT * from clientes;
SELECT * from productos;


-- Inserta una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Laptop"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Laptop'), 
 (SELECT id FROM clientes WHERE nombre = 'Juan Pérez'), 
 2, 1200.00, 
 (SELECT id FROM empleados WHERE nombre = 'Ana' AND apellido = 'Rodríguez'));

-- Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Teléfono móvil'), 
 (SELECT id FROM clientes WHERE nombre = 'María García'), 
 3, 450.00, 
 (SELECT id FROM empleados WHERE nombre = 'Carlos' AND apellido = 'López'));

-- Crea una venta en la tabla "ventas" donde el cliente "Carlos Sánchez" compra una "Impresora"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Impresora'), 
 (SELECT id FROM clientes WHERE nombre = 'Carlos Sánchez'), 
 1, 280.00, 
 (SELECT id FROM empleados WHERE nombre = 'Marta' AND apellido = 'Ramírez'));

-- Inserta una venta en la tabla "ventas" donde el cliente "Ana López" compra una "Laptop"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Laptop'), 
 (SELECT id FROM clientes WHERE nombre = 'Ana López'), 
 1, 1200.00, 
 (SELECT id FROM empleados WHERE nombre = 'Carlos' AND apellido = 'López'));

-- Crea una venta en la tabla "ventas" donde el cliente "Juan Pérez" compra una "Tablet"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Tablet'), 
 (SELECT id FROM clientes WHERE nombre = 'Juan Pérez'), 
 2, 350.00, 
 (SELECT id FROM empleados WHERE nombre = 'Luis' AND apellido = 'Fernández'));

-- Inserta una venta en la tabla "ventas" donde el cliente "María García" compra un "Teléfono móvil"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Teléfono móvil'), 
 (SELECT id FROM clientes WHERE nombre = 'María García'), 
 1, 450.00, 
 (SELECT id FROM empleados WHERE nombre = 'Marta' AND apellido = 'Ramírez'));

-- Crea una venta en la tabla "ventas" donde el cliente "Carlos Sánchez" compra una "Impresora"
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id) 
VALUES 
((SELECT id FROM productos WHERE nombre = 'Impresora'), 
 (SELECT id FROM clientes WHERE nombre = 'Carlos Sánchez'), 
 2, 280.00, 
 (SELECT id FROM empleados WHERE nombre = 'Lorena' AND apellido = 'Guzmán'));

-- Consulta de la tabla "ventas"
SELECT id, producto_id, cliente_id, cantidad, precio_unitario, monto_total, empleado_id FROM ventas;

-- Cláusula DISTINCT: Elimina duplicados de los resultados
-- Lista los nombres de los empleados sin duplicados
SELECT DISTINCT nombre 
FROM empleados;

-- Obtén una lista de correos electrónicos únicos de todos los empleados.
SELECT DISTINCT correo_electronico 
FROM empleados;

-- Encuentra la lista de edades distintas entre los empleados.
SELECT DISTINCT edad 
FROM empleados;

-- Operadores Relacionales: Comparaciones de datos
-- Muestra los nombres de los empleados que tienen un salario superior a $3200.
SELECT nombre 
FROM empleados 
WHERE salario > 3200;

-- Obtén una lista de empleados que tienen 28 años de edad.
SELECT nombre 
FROM empleados 
WHERE edad = 28;

-- Lista a los empleados cuyos salarios sean menores a $2700.
SELECT nombre 
FROM empleados 
WHERE salario < 2700;

-- Encuentra todas las ventas donde la cantidad de productos vendidos sea mayor que 2.
SELECT * 
FROM ventas 
WHERE cantidad > 2;

-- Muestra las ventas donde el precio unitario sea igual a $480.00.
SELECT * 
FROM ventas 
WHERE precio_unitario = 480.00;

-- Obtén una lista de ventas donde el monto total sea menor que $1000.00.
SELECT * 
FROM ventas 
WHERE monto_total < 1000.00;

-- Encuentra las ventas realizadas por el empleado con el empleado_id 1.
SELECT * 
FROM ventas 
WHERE empleado_id = 1;

-- Operadores Lógicos: Combinación de condiciones
-- Muestra los nombres de los empleados que trabajan en el Departamento 1 y tienen un salario superior a $3000.
SELECT nombre 
FROM empleados 
WHERE departamento_id = 1 AND salario > 3000;

-- Lista los empleados que tienen 32 años de edad o trabajan en el Departamento 3.
SELECT nombre 
FROM empleados 
WHERE edad = 32 OR departamento_id = 3;

-- Lista las ventas donde el producto sea el producto_id 1 y la cantidad sea mayor o igual a 2.
SELECT * 
FROM ventas 
WHERE producto_id = 1 AND cantidad >= 2;

-- Muestra las ventas donde el cliente sea el cliente_id 1 o el empleado sea el empleado_id 2.
SELECT * 
FROM ventas 
WHERE cliente_id = 1 OR empleado_id = 2;

-- Obtén una lista de ventas donde el cliente sea el cliente_id 2 y la cantidad sea mayor que 2.
SELECT * 
FROM ventas 
WHERE cliente_id = 2 AND cantidad > 2;

-- Encuentra las ventas realizadas por el empleado con el empleado_id 1 y donde el monto total sea mayor que $2000.00.
SELECT * 
FROM ventas 
WHERE empleado_id = 1 AND monto_total > 2000.00;

-- Cláusula BETWEEN: Rango de valores
-- Encuentra a los empleados cuyas edades están entre 29 y 33 años.
SELECT nombre, edad 
FROM empleados 
WHERE edad BETWEEN 29 AND 33;

-- Encuentra las ventas donde la cantidad de productos vendidos esté entre 2 y 3.
SELECT * 
FROM ventas 
WHERE cantidad BETWEEN 2 AND 3;

-- Muestra las ventas donde el precio unitario esté entre $300.00 y $500.00.
SELECT * 
FROM ventas 
WHERE precio_unitario BETWEEN 300.00 AND 500.00;



-- Ejercicios Cláusula IN
-- Encuentra los empleados cuyos IDs son 1, 3 o 5.
SELECT * 
FROM empleados 
WHERE id IN (1, 3, 5);

-- Busca los productos con IDs 2, 4 o 6 en la tabla de productos.
SELECT * 
FROM productos 
WHERE id IN (2, 4, 6);

-- Encuentra las ventas que tienen los clientes con IDs 1, 3 o 5.
SELECT * 
FROM ventas 
WHERE cliente_id IN (1, 3, 5);



-- Ejercicios Cláusula LIKE
-- Encuentra los empleados cuyos nombres comienzan con "L".
SELECT * 
FROM empleados 
WHERE nombre LIKE 'L%';

-- Busca los productos cuyos nombres contengan la palabra "Teléfono".
SELECT * 
FROM productos 
WHERE nombre LIKE '%Teléfono%';

-- Encuentra los clientes cuyas direcciones contienen la palabra "Calle".
SELECT * 
FROM clientes 
WHERE direccion LIKE '%Calle%';

-- Ejercicios Cláusula ORDER BY
-- Ordena los empleados por salario de manera ascendente.
SELECT * 
FROM empleados 
ORDER BY salario ASC;

-- Ordena los productos por nombre de manera descendente.
SELECT * 
FROM productos 
ORDER BY nombre DESC;

-- Ordena las ventas por cantidad de manera ascendente y luego por precio_unitario de manera descendente.
SELECT * 
FROM ventas 
ORDER BY cantidad ASC, precio_unitario DESC;



-- Ejercicios LIMIT
-- Muestra los 5 productos más caros de la tabla "productos".
SELECT * 
FROM productos 
ORDER BY precio DESC 
LIMIT 5;

-- Muestra los 10 primeros empleados en orden alfabético por apellido.
SELECT * 
FROM empleados 
ORDER BY apellido ASC 
LIMIT 10;

-- Muestra las 3 ventas con el monto total más alto.
SELECT * 
FROM ventas 
ORDER BY monto_total DESC 
LIMIT 3;


-- Ejercicios AS
-- Crea una consulta que muestre el salario de los empleados junto con el salario aumentado en un 10% nombrando a la columna como “Aumento del 10%”.
SELECT nombre, salario, salario * 1.10 AS "Aumento del 10%" 
FROM empleados;

-- Crea una consulta que calcule el monto total de las compras realizadas por cliente y que la columna se llame “Monto total gastado”.
SELECT cliente_id, SUM(monto_total) AS "Monto total gastado" 
FROM ventas 
GROUP BY cliente_id;

-- Muestra los nombres completos de los empleados concatenando los campos "nombre" y "apellido" y que la columna se llame “Nombre y apellido”.
SELECT CONCAT(nombre, ' ', apellido) AS "Nombre y apellido" 
FROM empleados;



-- Ejercicios CASE
-- Crea una consulta que muestre el nombre de los productos y los categorice como "Caro" si el precio es mayor o igual a $500, "Medio" si es mayor o igual a $200 y menor que $500, y "Barato" en otros casos.
SELECT nombre, 
       CASE 
           WHEN precio >= 500 THEN 'Caro'
           WHEN precio >= 200 AND precio < 500 THEN 'Medio'
           ELSE 'Barato' 
       END AS categoria 
FROM productos;

-- Crea una consulta que muestre el nombre de los empleados y los categorice como "Joven" si tienen menos de 30 años, "Adulto" si tienen entre 30 y 40 años, y "Mayor" si tienen más de 40 años.
SELECT nombre, 
       CASE 
           WHEN edad < 30 THEN 'Joven'
           WHEN edad BETWEEN 30 AND 40 THEN 'Adulto'
           ELSE 'Mayor' 
       END AS categoria 
FROM empleados;

-- Crea una consulta que muestre el ID de la venta y los categorice como "Poca cantidad" si la cantidad es menor que 3, "Cantidad moderada" si es igual o mayor que 3 y menor que 6, y "Mucha cantidad" en otros casos.
SELECT id, 
       CASE 
           WHEN cantidad < 3 THEN 'Poca cantidad'
           WHEN cantidad >= 3 AND cantidad < 6 THEN 'Cantidad moderada'
           ELSE 'Mucha cantidad' 
       END AS categoria 
FROM ventas;

-- Crea una consulta que muestre el nombre de los clientes y los categorice como "Comienza con A" si su nombre comienza con la letra 'A', "Comienza con M" si comienza con 'M' y "Otros" en otros casos.
SELECT nombre, 
       CASE 
           WHEN nombre LIKE 'A%' THEN 'Comienza con A'
           WHEN nombre LIKE 'M%' THEN 'Comienza con M'
           ELSE 'Otros' 
       END AS categoria 
FROM clientes;

-- Crea una consulta que muestre el nombre de los empleados y los categorice como "Salario alto" si el salario es mayor o igual a $3500, "Salario medio" si es mayor o igual a $3000 y menor que $3500, y "Salario bajo" en otros casos.
SELECT nombre, 
       CASE 
           WHEN salario >= 3500 THEN 'Salario alto'
           WHEN salario >= 3000 AND salario < 3500 THEN 'Salario medio'
           ELSE 'Salario bajo' 
       END AS categoria 
FROM empleados;


-- Ejercicios Función MAX()

-- Encuentra el salario máximo de todos los empleados
SELECT MAX(salario) AS salario_maximo 
FROM empleados;

-- Encuentra la cantidad máxima de productos vendidos en una sola venta
SELECT MAX(cantidad) AS cantidad_maxima_vendida 
FROM ventas;

-- Encuentra la edad máxima de los empleados
SELECT MAX(edad) AS edad_maxima 
FROM empleados;


-- Ejercicios Función MIN()

-- Encuentra el salario mínimo de todos los empleados
SELECT MIN(salario) AS salario_minimo 
FROM empleados;

-- Encuentra la cantidad mínima de productos vendidos en una sola venta
SELECT MIN(cantidad) AS cantidad_minima_vendida 
FROM ventas;

-- Encuentra la edad mínima de los empleados
SELECT MIN(edad) AS edad_minima 
FROM empleados;


-- Ejercicios de la Función COUNT()

-- Cuenta cuántos empleados hay en total
SELECT COUNT(*) AS total_empleados 
FROM empleados;

-- Cuenta cuántas ventas se han realizado
SELECT COUNT(*) AS total_ventas 
FROM ventas;

-- Cuenta cuántos productos tienen un precio superior a $500
SELECT COUNT(*) AS total_productos_mayores_500 
FROM productos 
WHERE precio > 500;


-- Ejercicios de la Función SUM()

-- Calcula la suma total de salarios de todos los empleados
SELECT SUM(salario) AS suma_salarios 
FROM empleados;

-- Calcula la suma total de montos vendidos en todas las ventas
SELECT SUM(monto_total) AS suma_montos_vendidos 
FROM ventas;

-- Calcula la suma de precios de productos con ID par
SELECT SUM(precio) AS suma_precios_productos_par 
FROM productos 
WHERE MOD(id, 2) = 0;


-- Ejercicios Función AVG()

-- Calcula el salario promedio de todos los empleados
SELECT AVG(salario) AS salario_promedio 
FROM empleados;

-- Calcula el precio unitario promedio de todos los productos
SELECT AVG(precio) AS precio_promedio 
FROM productos;

-- Calcula la edad promedio de los empleados
SELECT AVG(edad) AS edad_promedio 
FROM empleados;


-- EJERCICIOS CON FUNCIÓN GROUP BY

-- Agrupa las ventas por empleado y muestra la cantidad total de ventas realizadas por cada empleado.
SELECT empleado_id, COUNT(*) AS total_ventas
FROM ventas
GROUP BY empleado_id;

-- Agrupa los productos por precio y muestra la cantidad de productos con el mismo precio.
SELECT precio, COUNT(*) AS cantidad_productos
FROM productos
GROUP BY precio;

-- Agrupa los empleados por departamento y muestra la cantidad de empleados en cada departamento.
SELECT departamento_id, COUNT(*) AS cantidad_empleados
FROM empleados
GROUP BY departamento_id;


-- EJERCICIOS CON FUNCIÓN HAVING

-- Encuentra los departamentos con un salario promedio de sus empleados superior a $3,000.
SELECT departamento_id, AVG(salario) AS salario_promedio
FROM empleados
GROUP BY departamento_id
HAVING AVG(salario) > 3000;

-- Encuentra los productos que se han vendido al menos 5 veces.
SELECT producto_id, SUM(cantidad) AS total_vendido
FROM ventas
GROUP BY producto_id
HAVING SUM(cantidad) >= 5;


-- EJERCICIOS CON CLÁUSULA IN

-- Busca los empleados que trabajan en los departamentos 2 o 3.
SELECT * FROM empleados
WHERE departamento_id IN (2, 3);

-- Trae a los clientes que no tengan los IDs 2, 4 o 6.
SELECT * FROM clientes
WHERE id NOT IN (2, 4, 6);

-- Busca los productos cuyos precios son 350.00, 480.00 o 800.00.
SELECT * FROM productos
WHERE precio IN (350.00, 480.00, 800.00);


-- EJERCICIOS CON CLÁUSULA LIKE

-- Busca los empleados cuyos correos electrónicos terminan en "mail.com".
SELECT * FROM empleados
WHERE correo_electronico LIKE '%mail.com';

-- Encuentra los productos cuyos nombres tengan exactamente 6 caracteres.
SELECT * FROM productos
WHERE LENGTH(nombre) = 6;

-- Busca los clientes cuyos nombres tengan una "a" en la tercera posición.
SELECT * FROM clientes
WHERE SUBSTRING(nombre, 3, 1) = 'a';


-- EJERCICIOS CON FUNCIÓN MAX()

-- Encuentra el precio máximo de un producto.
SELECT MAX(precio) AS precio_maximo
FROM productos;

-- Encuentra el monto total máximo de una venta.
SELECT MAX(monto_total) AS monto_maximo
FROM ventas;


-- EJERCICIOS CON FUNCIÓN MIN()

-- Encuentra el precio mínimo de un producto.
SELECT MIN(precio) AS precio_minimo
FROM productos;

-- Encuentra el monto total mínimo de una venta.
SELECT MIN(monto_total) AS monto_minimo
FROM ventas;



-- EJERCICIOS CON FUNCIÓN CASE()

-- Crea una consulta que muestre el nombre de los productos y los categorice como "Laptop" si el nombre contiene la palabra "Laptop", "Teléfono" si contiene la palabra "Teléfono", y "Otros" en otros casos.
SELECT nombre,
       CASE
           WHEN nombre LIKE '%Laptop%' THEN 'Laptop'
           WHEN nombre LIKE '%Teléfono%' THEN 'Teléfono'
           ELSE 'Otros'
       END AS categoria
FROM productos;

-- Crea una consulta que muestre el ID del producto y los clasifique en categorías según la cantidad total de ventas de cada producto en la tabla 'ventas'. Utilizando una instrucción 'CASE', establece las siguientes categorías: 
-- Si la suma de la cantidad de ventas (SUM(cantidad)) es mayor o igual a 9, la categoría es 'Alto Volumen'. 
-- Si la suma de la cantidad de ventas está entre 4 y 8 (inclusive), la categoría es 'Medio Volumen'.
-- En otros casos, la categoría es 'Bajo Volumen'.
SELECT producto_id,
       CASE
           WHEN SUM(cantidad) >= 9 THEN 'Alto Volumen'
           WHEN SUM(cantidad) BETWEEN 4 AND 8 THEN 'Medio Volumen'
           ELSE 'Bajo Volumen'
       END AS categoria
FROM ventas
GROUP BY producto_id
ORDER BY SUM(cantidad) DESC;


-- Crea una consulta que muestre el ID de la venta y los categorice como "Venta pequeña" si el monto total es menor que $500, "Venta mediana" si es mayor o igual a $500 y menor que $1500, y "Venta grande" en otros casos.
SELECT id,
       CASE
           WHEN monto_total < 500 THEN 'Venta pequeña'
           WHEN monto_total BETWEEN 500 AND 1499 THEN 'Venta mediana'
           ELSE 'Venta grande'
       END AS categoria
FROM ventas;

-- Crea una consulta que muestre el nombre de los clientes y los categorice como "Dirección larga" si la longitud de su dirección es mayor o igual a 30 caracteres, "Dirección mediana" si es mayor o igual a 20 y menor que 30 caracteres, y "Dirección corta" en otros casos.
SELECT nombre, direccion,
       CASE
           WHEN LENGTH(direccion) >= 30 THEN 'Dirección larga'
           WHEN LENGTH(direccion) >= 20 THEN 'Dirección mediana'
           ELSE 'Dirección corta'
       END AS categoria
FROM clientes;

-- Crea una consulta que muestre el nombre de los empleados y los categorice como "Ventas" si pertenecen al departamento 1, "Recursos Humanos" si pertenecen al departamento 2, y "Contabilidad"  si pertenecen al departamento 3.
SELECT nombre,
       CASE
           WHEN departamento_id = 1 THEN 'Ventas'
           WHEN departamento_id = 2 THEN 'Recursos Humanos'
           WHEN departamento_id = 3 THEN 'Contabilidad'
           ELSE 'Otro'
       END AS categoria
FROM empleados;

-- Crea una consulta que muestre el nombre de los productos y los categorice de la siguiente manera:
-- Si el nombre del producto está en la lista ('Laptop', 'Reloj de Pulsera Inteligente', 'Reproductor de Blu-ray', 'Auriculares Bluetooth', 'Smart TV 55 Pulgadas', 'Cámara Digital', 'Impresora', 'Tablet', 'Teléfono móvil') y el precio es mayor o igual a 1000, la categoría es 'Tecnología cara'.
-- Si el nombre del producto está en la lista anterior y el precio está entre 500 y 999 (inclusive), la categoría es 'Tecnología gama media'.
-- Si el nombre del producto está en la lista anterior y el precio es menor a 500, la categoría es 'Tecnología barata'.
-- Si el precio es mayor o igual a 1000 y el nombre del producto no está en la lista, la categoría es 'Caro'.
-- Si el precio está entre 500 y 999 (inclusive) y el nombre del producto no está en la lista, la categoría es 'Medio'.
-- Si el precio es menor a 500 y el nombre del producto no está en la lista, la categoría es 'Barato'.
SELECT nombre, precio,
       CASE
           WHEN nombre IN ('Laptop', 'Reloj de Pulsera Inteligente', 'Reproductor de Blu-ray', 'Auriculares Bluetooth', 'Smart TV 55 Pulgadas', 'Cámara Digital', 'Impresora', 'Tablet', 'Teléfono móvil') AND precio >= 1000 THEN 'Tecnología cara'
           WHEN nombre IN ('Laptop', 'Reloj de Pulsera Inteligente', 'Reproductor de Blu-ray', 'Auriculares Bluetooth', 'Smart TV 55 Pulgadas', 'Cámara Digital', 'Impresora', 'Tablet', 'Teléfono móvil') AND precio BETWEEN 500 AND 999 THEN 'Tecnología gama media'
           WHEN nombre IN ('Laptop', 'Reloj de Pulsera Inteligente', 'Reproductor de Blu-ray', 'Auriculares Bluetooth', 'Smart TV 55 Pulgadas', 'Cámara Digital', 'Impresora', 'Tablet', 'Teléfono móvil') AND precio < 500 THEN 'Tecnología barata'
           WHEN precio >= 1000 THEN 'Caro'
           WHEN precio BETWEEN 500 AND 999 THEN 'Medio'
           ELSE 'Barato'
       END AS categoria
FROM productos;


-- Ejercicios consultas multitabla - Parte 1

-- 1. Une las tablas de empleados con departamentos y solo muestra las columnas nombre, apellido, edad, salario de empleados y la columna nombre de departamentos.
SELECT e.nombre, e.apellido, e.edad, e.salario,
       (SELECT d.nombre FROM departamentos d WHERE d.id = e.departamento_id) AS departamento
FROM empleados e;

-- 2. Une las tablas ventas con la tabla empleados donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados.
SELECT v.*, 
       (SELECT e.nombre FROM empleados e WHERE e.id = v.empleado_id) AS nombre_empleado,
       (SELECT e.apellido FROM empleados e WHERE e.id = v.empleado_id) AS apellido_empleado
FROM ventas v;

-- 3. Une las tablas ventas con la tabla productos donde se muestren todas las columnas de ventas exceptuando la columna producto_id y en su lugar muestres la columna nombre de la tabla productos.
SELECT v.*, 
       (SELECT p.nombre FROM productos p WHERE p.id = v.producto_id) AS producto
FROM ventas v;

-- 4. Une las tablas ventas con la tabla clientes donde se muestren todas las columnas de ventas exceptuando la columna cliente_id y en su lugar muestres la columna nombre de la tabla clientes.
SELECT v.*, 
       (SELECT c.nombre FROM clientes c WHERE c.id = v.cliente_id) AS cliente
FROM ventas v;

-- 5. Une las tablas ventas con las tablas empleados y departamentos donde se muestren todas las columnas de ventas exceptuando la columna empleado_id y en su lugar muestres el nombre y apellido de la tabla empleados y además muestres la columna nombre de la tabla departamentos.
SELECT v.*, 
       (SELECT e.nombre FROM empleados e WHERE e.id = v.empleado_id) AS nombre_empleado,
       (SELECT e.apellido FROM empleados e WHERE e.id = v.empleado_id) AS apellido_empleado,
       (SELECT d.nombre FROM departamentos d WHERE d.id = (SELECT e.departamento_id FROM empleados e WHERE e.id = v.empleado_id)) AS departamento
FROM ventas v;

-- 6. Une las tablas ventas, empleados, productos y clientes donde se muestren las columnas de la tabla ventas reemplazando sus columnas de FOREIGN KEYs con las respectivas columnas de “nombre” de las otras tablas.
SELECT v.*, 
       (SELECT e.nombre FROM empleados e WHERE e.id = v.empleado_id) AS nombre_empleado,
       (SELECT e.apellido FROM empleados e WHERE e.id = v.empleado_id) AS apellido_empleado,
       (SELECT p.nombre FROM productos p WHERE p.id = v.producto_id) AS producto,
       (SELECT c.nombre FROM clientes c WHERE c.id = v.cliente_id) AS cliente
FROM ventas v;


-- Ejercicios consultas multitabla - Parte 2

-- 1. Calcular el monto total de ventas por departamento y mostrar el nombre del departamento junto con el monto total de ventas.
SELECT 
    (SELECT nombre FROM departamentos d 
     WHERE d.id = 
        (SELECT departamento_id FROM empleados e WHERE e.id = v.empleado_id)
    ) AS departamento, 
    SUM(v.monto_total) AS monto_total_ventas
FROM ventas v
GROUP BY departamento;

-- 2. Encontrar el empleado más joven de cada departamento y mostrar el nombre del departamento junto con la edad del empleado más joven.
SELECT 
    (SELECT nombre FROM departamentos d 
     WHERE d.id = 
        (SELECT departamento_id FROM empleados e WHERE e.id = e2.id)
    ) AS departamento,
    e2.nombre, e2.apellido, e2.edad
FROM empleados e2
WHERE e2.edad = (
    SELECT MIN(edad) FROM empleados e3 WHERE e3.departamento_id = e2.departamento_id
)
ORDER BY departamento;

-- 3. Calcular el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 “bajo”, menos 8 “medio” y mayor o igual a 8 “alto”) y mostrar la categoría de volumen junto con la cantidad y el nombre del producto.
SELECT 
    p.nombre AS producto_nombre, 
    SUM(v.cantidad) AS cantidad_vendida,
    CASE 
        WHEN SUM(v.cantidad) < 5 THEN 'bajo'
        WHEN SUM(v.cantidad) < 8 THEN 'medio'
        ELSE 'alto'
    END AS volumen_categoria
FROM ventas v
JOIN productos p ON v.producto_id = p.id
GROUP BY producto_nombre;

-- 4. Encontrar el cliente que ha realizado el mayor monto total de compras y mostrar su nombre y el monto total.
SELECT 
    c.nombre AS cliente_nombre, 
    SUM(v.monto_total) AS monto_total_compras
FROM ventas v
JOIN clientes c ON v.cliente_id = c.id
GROUP BY cliente_nombre
ORDER BY monto_total_compras DESC
LIMIT 1;

-- 5. Calcular el precio promedio de los productos vendidos por cada empleado y mostrar el nombre del empleado junto con el precio promedio de los productos que ha vendido.
SELECT 
    e.nombre, e.apellido, 
    AVG(p.precio) AS precio_promedio
FROM ventas v
JOIN empleados e ON v.empleado_id = e.id
JOIN productos p ON v.producto_id = p.id
GROUP BY e.nombre, e.apellido;

-- 6. Encontrar el departamento con el salario mínimo más bajo entre los empleados y mostrar el nombre del departamento junto con el salario mínimo más bajo.
SELECT 
    (SELECT nombre FROM departamentos d 
     WHERE d.id = e.departamento_id
    ) AS departamento, 
    MIN(e.salario) AS salario_minimo
FROM empleados e
GROUP BY departamento
ORDER BY salario_minimo ASC
LIMIT 1;

-- 7. Encuentra el departamento con el salario promedio más alto entre los empleados mayores de 30 años y muestra el nombre del departamento junto con el salario promedio. Limita los resultados a mostrar solo los departamentos con el salario promedio mayor a 3320.
SELECT 
    (SELECT nombre FROM departamentos d 
     WHERE d.id = e.departamento_id
    ) AS departamento, 
    AVG(e.salario) AS salario_promedio
FROM empleados e
WHERE e.edad > 30
GROUP BY departamento
HAVING salario_promedio > 3320
ORDER BY salario_promedio DESC;