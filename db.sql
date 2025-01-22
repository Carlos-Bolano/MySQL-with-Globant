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

-- Registros adicionales para la siguiente clase
INSERT INTO empleados (nombre, apellido, edad, salario, departamento_id)
VALUES
  ('Laura', 'Sánchez', 27, 3300.00, 1),
  ('Javier', 'Pérez', 29, 3100.00, 1),
  ('Camila', 'Gómez', 26, 3000.00, 1),
  ('Lucas', 'Fernández', 28, 3200.00, 1),
  ('Valentina', 'Rodríguez', 30, 3500.00, 1);
INSERT INTO productos (nombre, precio)
VALUES
  ('Cámara Digital', 420.00),
  ('Smart TV 55 Pulgadas', 1200.00),
  ('Auriculares Bluetooth', 80.00),
  ('Reproductor de Blu-ray', 120.00),
  ('Lavadora de Ropa', 550.00),
  ('Refrigeradora Doble Puerta', 800.00),
  ('Horno de Microondas', 120.00),
  ('Licuadora de Alta Potencia', 70.00),
  ('Silla de Oficina Ergonómica', 150.00),
  ('Escritorio de Madera', 200.00),
  ('Mesa de Comedor', 250.00),
  ('Sofá de Tres Plazas', 350.00),
  ('Mochila para Portátil', 30.00),
  ('Reloj de Pulsera Inteligente', 100.00),
  ('Juego de Utensilios de Cocina', 40.00),
  ('Set de Toallas de Baño', 20.00),
  ('Cama King Size', 500.00),
  ('Lámpara de Pie Moderna', 70.00),
  ('Cafetera de Goteo', 40.00),
  ('Robot Aspirador', 180.00);
INSERT INTO clientes (nombre, direccion)
VALUES
  ('Alejandro López', 'Calle Rivadavia 123, Buenos Aires'),
  ('Sofía Rodríguez', 'Avenida San Martín 456, Rosario'),
  ('Joaquín Pérez', 'Calle Belgrano 789, Córdoba'),
  ('Valeria Gómez', 'Calle Mitre 101, Mendoza'),
  ('Diego Martínez', 'Avenida 9 de Julio 654, Buenos Aires');
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (1, 6, 3, 1350.00, 1),
  (5, 8, 5, 420.00, 9),
  (10, 2, 2, 800.00, 6),
  (14, 7, 1, 200.00, 5),
  (20, 4, 4, 20.00, 6),
  (4, 5, 5, 280.00, 1),
  (9, 5, 3, 550.00, 1),
  (13, 3, 4, 150.00, 5),
  (19, 6, 2, 40.00, 1),
  (2, 9, 5, 480.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (3, 9, 1, 350.00, 1),
  (6, 7, 4, 1200.00, 1),
  (7, 6, 3, 80.00, 1),
  (12, 9, 5, 70.00, 1),
  (16, 8, 2, 350.00, 6),
  (23, 9, 4, 180.00, 1),
  (18, 4, 3, 100.00, 7),
  (11, 3, 2, 120.00, 5),
  (15, 5, 4, 250.00, 6),
  (8, 8, 1, 120.00, 7);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (17, 3, 2, 30.00, 5),
  (21, 9, 5, 500.00, 6),
  (22, 2, 3, 70.00, 6),
  (24, 9, 2, 180.00, 1),
  (5, 1, 2, 1350.00, 1),
  (9, 6, 4, 550.00, 9),
  (13, 8, 3, 150.00, 7),
  (3, 1, 5, 350.00, 1),
  (18, 9, 1, 100.00, 6),
  (10, 5, 2, 800.00, 1);
INSERT INTO ventas (producto_id, cliente_id, cantidad, precio_unitario, empleado_id)
VALUES
  (7, 4, 3, 80.00, 6),
  (2, 5, 1, 480.00, 6),
  (8, 7, 4, 120.00, 7),
  (1, 3, 5, 1350.00, 5),
  (4, 6, 2, 280.00, 5),
  (12, 1, 1, 70.00, 1),
  (19, 4, 3, 40.00, 6),
  (15, 3, 4, 250.00, 5),
  (6, 8, 2, 1200.00, 7),
  (11, 2, 3, 120.00, 5);

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


--  Ejercicios JOIN Parte 1
-- Encuentra el nombre y apellido de los empleados junto con la cantidad total de ventas que han realizado.
SELECT e.nombre, e.apellido, SUM(v.cantidad) as "Cantidad Total de Ventas"
FROM empleados e
INNER JOIN ventas v
ON e.id = v.empleado_id
GROUP BY e.nombre, e.apellido;

-- Calcula el monto total vendido a cada cliente y muestra el nombre del cliente, su dirección y el monto total.
SELECT c.nombre, c.direccion , SUM(v.monto_total) as "Monto Total"
FROM clientes c
LEFT JOIN ventas v
ON c.id = v.cliente_id
GROUP BY c.nombre, c.direccion;


-- Encuentra los productos vendidos por cada empleado en el departamento de "Ventas" y muestra el nombre del empleado junto con el nombre de los productos que han vendido.
SELECT e.nombre empleado, p.nombre producto
FROM empleados e
INNER JOIN ventas v
ON e.id = v.empleado_id
INNER JOIN productos p
ON v.producto_id = p.id
INNER JOIN departamentos d
ON e.departamento_id = d.id WHERE d.nombre = "Ventas";


-- Encuentra el nombre del cliente, el nombre del producto y la cantidad comprada de productos con un precio superior a $500.
SELECT c.nombre Cliente, p.nombre Producto, SUM(v.cantidad) "Cantidad
Comprada"
FROM clientes c
INNER JOIN ventas v
ON c.id = v.cliente_id
INNER JOIN productos p
ON v.producto_id = p.id WHERE p.precio > 500
GROUP BY p.nombre, c.nombre;


-- Ejercicios JOIN Parte 2
-- Calcula la cantidad de ventas por departamento, incluso si el departamento no tiene ventas.
SELECT d.nombre Departamento, COUNT(v.id) as "Cantidad de Ventas"
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
LEFT JOIN ventas v
ON e.id = v.empleado_id
GROUP BY d.nombre;
-- Encuentra el nombre y la dirección de los clientes que han comprado más de 3 productos y muestra la cantidad de productos comprados.
SELECT c.nombre AS Cliente, c.direccion AS Direccion, COUNT(DISTINCT
v.producto_id) AS "Cantidad de Productos Comprados"
FROM clientes c
LEFT JOIN ventas v
ON c.id = v.cliente_id
GROUP BY c.nombre, c.direccion
HAVING COUNT(DISTINCT v.producto_id) > 3;
-- Calcula el monto total de ventas realizadas por cada departamento y muestra el nombre del departamento junto con el monto total de ventas.
SELECT d.nombre Departamento, SUM(v.monto_total) "Monto Total de Ventas"
FROM departamentos d
LEFT JOIN empleados e
ON d.id = e.departamento_id
LEFT JOIN ventas v
ON e.id = v.empleado_id
GROUP BY d.nombre;

--  Actividad: Ejercicios Complementarios
-- ✨ Estos ejercicios son de tipo complementario. Esto quiere decir que te ayudará a avanzar en profundidad en el tema visto, pero no son obligatorios. Te recomendamos intentar con tu equipo trabajar algunos de ellos. 

-- Muestra el nombre y apellido de los empleados que pertenecen al departamento de "Recursos Humanos" y han realizado más de 5 ventas.
SELECT e.nombre AS "Nombre", e.apellido AS "Apellido"
FROM empleados e
JOIN ventas v ON e.id = v.empleado_id
JOIN departamentos d ON e.departamento_id = d.id
WHERE d.nombre = 'Ventas'
GROUP BY e.nombre, e.apellido
HAVING COUNT(v.id) > 5;

-- Muestra el nombre y apellido de todos los empleados junto con la cantidad total de ventas que han realizado, incluso si no han realizado ventas.
SELECT e.nombre AS "Nombre", e.apellido AS "Apellido", COUNT(v.id) AS "Total de Ventas"
FROM empleados e
LEFT JOIN ventas v ON e.id = v.empleado_id
GROUP BY e.nombre, e.apellido;

-- Encuentra el empleado más joven de cada departamento y muestra el nombre del departamento junto con el nombre y la edad del empleado más joven.
SELECT d.nombre AS "Nombre del Departamento", 
       e.nombre AS "Nombre del Empleado", 
       e.apellido AS "Apellido del Empleado", 
       e.edad AS "Edad"
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.id
JOIN (
    SELECT departamento_id, MIN(edad) AS edad_minima
    FROM empleados
    GROUP BY departamento_id
) e_min ON e.departamento_id = e_min.departamento_id AND e.edad = e_min.edad_minima;

-- Calcula el volumen de productos vendidos por cada producto (por ejemplo, menos de 5 como "bajo", entre 5 y 10 como "medio", y más de 10 como
--  "alto") y muestra la categoría de volumen junto con la cantidad y el nombre del producto.
SELECT p.nombre AS "Nombre del Producto", 
       SUM(v.cantidad) AS "Cantidad Total Vendida",
       CASE
           WHEN SUM(v.cantidad) < 5 THEN 'Bajo'
           WHEN SUM(v.cantidad) BETWEEN 5 AND 10 THEN 'Medio'
           ELSE 'Alto'
       END AS "Categoría de Volumen"
FROM productos p
JOIN ventas v ON p.id = v.producto_id
GROUP BY p.nombre;

-- Base de datos Relacionales - MySQL: USO de Tablas Temporales
-- Ejercicios Prácticos con Tablas Temporales

-- Utiliza TABLE para consultar la tabla productos de manera simple, ordenando los productos de forma descendente por precio y solo 10 filas.
TABLE productos ORDER BY precio DESC LIMIT 2;

-- Crea una tabla temporal de los empleados donde unifiques su nombre y apellido en una sola columna.
DROP TEMPORARY TABLE IF EXISTS empleados_temp;
CREATE TEMPORARY TABLE empleados_temp AS
SELECT CONCAT(nombre, ' ', apellido) as nombre_completo
FROM empleados;

-- Crea una tabla temporal de la tabla clientes donde solo tengas la columna nombre.
DROP TEMPORARY TABLE IF EXISTS clientes_temp;
CREATE TEMPORARY TABLE clientes_temp AS
SELECT nombre as nombre_cliente
FROM clientes;
-- ver los resultados de la tabla temporal 
SELECT *
FROM clientes_temp;

-- Realiza la unión entre las tablas temporales de empleados y clientes usando TABLE.
SELECT e.nombre AS nombre_empleado
FROM empleados e
UNION
SELECT c.nombre as nombre_cliente
FROM clientes c;

-- Crea una tabla temporal escuela primaria que tenga las siguientes columnas: id(int), nombre(varchar), apellido(varchar), edad(int) y grado(int). Y que tenga los siguientes valores:
-- ID: 1, Nombre: Alejandro, Apellido: González, Edad: 11, Grado: 5
-- ID: 2, Nombre: Isabella, Apellido: López, Edad: 10, Grado: 4
-- ID: 3, Nombre: Lucas, Apellido: Martínez, Edad: 11, Grado: 5 
-- ID: 4, Nombre: Sofía, Apellido: Rodríguez, Edad: 10, Grado: 4 
-- ID: 5, Nombre: Mateo, Apellido: Pérez, Edad: 12, Grado: 6 
-- ID: 6, Nombre: Valentina, Apellido: Fernández, Edad: 12, Grado: 6
-- ID: 7, Nombre: Diego, Apellido: Torres, Edad: 10, Grado: 4
-- ID: 8, Nombre: Martina, Apellido: Gómez, Edad: 11, Grado: 5
-- ID: 9, Nombre: Joaquín, Apellido: Hernández, Edad: 10, Grado: 4
-- ID: 10, Nombre: Valeria, Apellido: Díaz, Edad: 11, Grado: 5
DROP TEMPORARY TABLE IF EXISTS escuela_primaria;
CREATE TEMPORARY TABLE escuela_primaria(
    Id INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    grado INT
);

INSERT INTO escuela_primaria(id, nombre, apellido, edad, grado)
VALUES (1, 'Alejandro', 'González', 11, 5),
    (2, 'Isabella', 'López', 10, 4),
    (3, 'Lucas', 'Martínez', 11, 5),
    (4, 'Sofía', 'Rodríguez', 10, 4),
    (5, 'Mateo', 'Pérez', 12, 6),
    (6, 'Valentina', 'Fernández', 12, 6),
    (7, 'Diego', 'Torres', 10, 4),
    (8, 'Martina', 'Gómez', 11, 5),
    (9, 'Joaquín', 'Hernández', 10, 4),
    (10, 'Valeria', 'Díaz', 11, 5);

-- ver los resultados de la tabla temporal 
TABLE escuela_primaria; 

-- Ejercicios Complementarios con Tablas Temporales 
-- Agrega un cliente nuevo con el nombre “Ana Rodríguez” y con dirección en “San Martín 2515, Mar del Plata”. Luego realiza la intersección entre la tabla temporal de empleados y clientes.
-- agregar el ciente
INSERT INTO clientes (nombre, direccion)
VALUES (
        'Ana Rodríguez',
        'San Martín 2515, Mar del Plata'
    );
-- mostrar la interserccion
SELECT nombre
FROM clientes
INTERSECT
SELECT nombre_cliente
FROM clientes_temp;

-- Realiza la excepción entre la tabla temporal de clientes y la de empleados.
TABLE clientes_temp
EXCEPT TABLE empleados_temp;
-- Crea una tabla temporal escuela secundaria que tenga las siguientes columnas:
--  id(int), nombre(varchar), apellido(varchar), edad(int) y grado(int). Y que tenga los siguientes valores:
-- ID: 1, Nombre: Eduardo, Apellido: Sánchez, Edad: 16, Grado: 10
-- ID: 2, Nombre: Camila, Apellido: Martín, Edad: 17, Grado: 11
-- ID: 3, Nombre: Manuel, Apellido: Gutiérrez, Edad: 15, Grado: 9
-- ID: 4, Nombre: Laura, Apellido: García, Edad: 16, Grado: 10
-- ID: 11, Nombre: Pablo, Apellido: Ortega, Edad: 17, Grado: 11
-- ID: 12, Nombre: Carmen, Apellido: Ramírez, Edad: 15, Grado: 9
-- ID: 13, Nombre: Carlos, Apellido: Molina, Edad: 16, Grado: 10
-- ID: 14, Nombre: Ana, Apellido: Ruiz, Edad: 17, Grado: 11
-- ID: 15, Nombre: Luis, Apellido: Fernández, Edad: 15, Grado: 9
-- ID: 16, Nombre: María, Apellido: López, Edad: 16, Grado: 10
DROP TEMPORARY TABLE IF EXISTS escuela_secundaria;
CREATE TEMPORARY TABLE escuela_secundaria(
    Id INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    grado INT
);

-- insertar los datos requeridos
INSERT INTO escuela_secundaria(id, nombre, apellido, edad, grado)
VALUES (1, 'Eduardo', 'Sánchez', 16, 10),
    (2, 'Camila', 'Martín', 17, 11),
    (3, 'Manuel', 'Gutiérrez', 15, 9),
    (4, 'Laura', 'García', 16, 10),
    (11, 'Pablo', 'Ortega', 17, 11),
    (12, 'Carmen', 'Ramírez', 15, 9),
    (13, 'Carlos', 'Molina', 16, 10),
    (14, 'Ana', 'Ruiz', 17, 11),
    (15, 'Luis', 'Fernández', 15, 9),
    (16, 'María', 'López', 16, 10);
-- mostrar los datos de la tabla temporal 
TABLE escuela_secundaria;

-- Realiza la intersección de la escuela primaria y escuela secundaria con el nombre y apellido de los alumnos para saber quienes fueron a ambas escuelas.
SELECT nombre
FROM escuela_primaria
INTERSECT
SELECT nombre
FROM escuela_secundaria;

-- la interserccion se ejecuta bien y no muestra ningun alumno 
TABLE escuela_primaria
INTERSECT
TABLE escuela_secundaria;

-- Realiza la excepción de la escuela primaria con la secundaria para saber quienes no siguieron cursando en dicha escuela secundaria.
TABLE escuela_primaria
EXCEPT TABLE escuela_secundaria;

-- Realiza la unión de la escuela primaria y secundaria con la columna grado para saber cuáles son los grados que abarcan ambas escuelas, y ordénalos de forma descendente.
SELECT grado
FROM escuela_primaria
UNION
SELECT grado
FROM escuela_secundaria
ORDER BY grado DESC;

-- ✏️Ejercicios  Subconsultas All y Any
-- 1. Encuentra los nombres de los clientes que han realizado compras de productos 
-- con un precio superior a la media de precios de todos los productos.
SELECT DISTINCT c.nombre, p.nombre, p.precio
FROM clientes c
    JOIN ventas v ON c.id = v.cliente_id
    JOIN productos p ON v.producto_id = p.id
WHERE p.precio > (
        SELECT AVG(precio)
        FROM productos
    );

-- 2. Encuentra los empleados cuyo salario sea mayor que al menos uno de los salarios 
-- de los empleados del departamento de "Ventas".
SELECT e.nombre, e.salario
FROM empleados e
    JOIN departamentos d ON d.id = e.departamento_id
WHERE e.salario > ANY (
        SELECT salario
        FROM empleados
        WHERE d.nombre = 'Ventas'
    );

-- 3. Encuentra los productos cuyos precios sean mayores que todos los precios 
-- de los productos con la palabra "Móvil" en su nombre.
SELECT nombre,
    precio
FROM productos
WHERE precio > ALL (
        SELECT precio
        FROM productos
        WHERE nombre LIKE '%Móvil%'
    );

-- 4. Muestra la información de los clientes que realizaron la compra con el monto 
-- total más alto, incluyendo su nombre, dirección y el monto total de compra.
SELECT c.nombre,
    c.direccion,
    v.monto_total
FROM clientes c
    JOIN ventas v ON c.id = v.cliente_id
WHERE v.monto_total = (
        SELECT MAX(monto_total)
        FROM ventas
    );

-- 5. Para cada departamento, encuentra el empleado con el salario más alto.
-- Muestra el nombre del departamento junto con el nombre del empleado y su salario.
SELECT e.nombre AS nombre_empleado, e.salario, d.nombre AS departamento
FROM empleados e
    JOIN departamentos d ON d.id = e.departamento_id
WHERE e.salario = (
        SELECT MAX(salario)
        FROM empleados
        WHERE e.departamento_id = d.id
    );


-- ✏️Ejercicios  Subconsultas All y Any
-- 1. Empleados que ganan más que el salario promedio de los empleados del departamento de "Contabilidad".
SELECT e.nombre as nombre_empleado, e.apellido, e.salario
FROM empleados e 
JOIN departamentos d ON d.id = departamento_id
WHERE salario > (
    SELECT AVG(salario)
    FROM empleados
    WHERE d.nombre = 'ventas'
);

-- 2. Productos con un precio superior al de al menos uno de los productos vendidos al cliente "Juan Pérez".
SELECT nombre, precio
FROM productos
WHERE precio > ANY (
    SELECT p.precio
    FROM productos p
    JOIN ventas v ON p.id = v.producto_id
    JOIN clientes c ON v.cliente_id = c.id
    WHERE c.nombre = 'Juan Pérez'
);

-- 3. Departamentos con al menos un empleado menor de 30 años.
SELECT DISTINCT d.nombre as departamento, e.nombre as empleado, e.edad
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id
WHERE e.edad < 30;

-- 4. Empleado más joven entre los 3 empleados con más productos vendidos.
-- Empleado más joven entre los 3 empleados con más productos vendidos
SELECT e.nombre, e.apellido, e.edad
FROM empleados e
JOIN (
    -- Subconsulta para obtener los 3 empleados con más productos vendidos
    SELECT v.empleado_id
    FROM ventas v
    GROUP BY v.empleado_id
    ORDER BY COUNT(v.producto_id) DESC
    LIMIT 3
) top_empleados ON e.id = top_empleados.empleado_id
ORDER BY e.edad ASC
LIMIT 1;


-- 5. Para cada cliente, encuentra el empleado que realizó la venta con el monto más alto.
SELECT c.nombre AS cliente, e.nombre AS empleado, v.monto_total
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
JOIN empleados e ON v.empleado_id = e.id
WHERE v.monto_total = (
    SELECT MAX(v2.monto_total)
    FROM ventas v2
    WHERE v2.cliente_id = c.id
);

-- ✏️Ejercicios  Complementarios 
-- ✨ Estos ejercicios son de tipo complementario. Esto quiere decir que te ayudará a avanzar en profundidad en el tema visto, pero no son obligatorios. Te recomendamos intentar con tu equipo trabajar algunos de ellos.

-- 1. Clientes que no han realizado ninguna compra.
SELECT nombre, direccion
FROM clientes
WHERE id NOT IN (
    SELECT cliente_id
    FROM ventas
);

-- 2. Productos vendidos más veces que cualquier producto con precio superior a 500.
SELECT nombre
FROM productos
WHERE id IN (
    SELECT producto_id
    FROM ventas
    GROUP BY producto_id
    HAVING COUNT(*) > ALL (
        SELECT COUNT(*)
        FROM ventas v
        JOIN productos p ON v.producto_id = p.id
        WHERE p.precio > 500
        GROUP BY v.producto_id
    )
);

-- 3. Empleados cuya edad sea menor que la de al menos un empleado del departamento "Recursos Humanos".
SELECT e.nombre, e.edad
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id
WHERE e.edad > ANY (
    SELECT e.edad
    WHERE d.nombre = 'Recursos Humanos'
);

-- 4. Productos con precios menores o iguales a todos los productos con "Cámara" en su nombre.
SELECT nombre, precio
FROM productos
WHERE precio <= ALL (
    SELECT precio
    FROM productos
    WHERE nombre LIKE '%Cámara%'
);

-- 5. Empleados con salarios superiores al promedio salarial.
SELECT nombre, salario
FROM empleados
WHERE salario > (
    SELECT AVG(salario)
    FROM empleados
);

-- 6. Empleados con salarios inferiores al promedio del departamento "Ventas".
SELECT e.nombre, e.salario
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id
WHERE d.nombre = 'Ventas' AND e.salario < (
    SELECT AVG(e2.salario)
    FROM empleados e2
    JOIN departamentos d2 ON d2.id = e2.departamento_id
    WHERE d2.nombre = 'Ventas'
);

-- 7. Clientes que han comprado productos con precio_unitario inferior al promedio de precios.
SELECT DISTINCT c.nombre
FROM clientes c
JOIN ventas v ON c.id = v.cliente_id
JOIN productos p ON v.producto_id = p.id
WHERE p.precio < (
    SELECT AVG(precio)
    FROM productos
);

-- 8. Empleados con salario igual a al menos uno del departamento "Recursos Humanos".
SELECT e.nombre, e.salario
FROM empleados e
JOIN departamentos d ON d.id = e.departamento_id
WHERE e.salario = ANY (
    SELECT e2.salario
    FROM empleados e2
    JOIN departamentos d2 ON d2.id = e2.departamento_id
    WHERE d2.nombre = 'Recursos Humanos'
);

-- 9. Productos cuyo precio es mayor o igual a todos los productos con "Refrigeradora" en su nombre.
SELECT nombre, precio
FROM productos
WHERE precio >= ALL (
    SELECT precio
    FROM productos
    WHERE nombre LIKE '%Refrigeradora%'
);

-- 10. Empleado con el salario más alto por debajo del promedio salarial.
SELECT nombre, apellido, salario
FROM empleados
WHERE salario = (
    SELECT MAX(salario)
    FROM empleados
    WHERE salario < (
        SELECT AVG(salario)
        FROM empleados
    )
);


-- Base de datos Relacionales - MySQL: Funciones de Texto
-- Ejercicios con funciones de texto - Parte 1

-- Ejercicios funciones de texto:
-- Crea una tabla llamada "estudiantes" con cinco columnas: "id" de tipo INT como clave primaria, "nombre" de tipo VARCHAR(50), "apellido" de tipo VARCHAR(50), "edad" de tipo INT y "promedio" de tipo FLOAT. Luego, inserta cinco filas en la tabla "estudiantes" con los siguientes datos:
-- ID: 1, Nombre: Juan, Apellido: Pérez, Edad: 22, Promedio: 85.5
-- ID: 2, Nombre: María, Apellido: Gómez, Edad: 21, Promedio: 90.0
-- ID: 3, Nombre: Luis, Apellido: Rodríguez, Edad: 20, Promedio: 88.5
-- ID: 4, Nombre: Ana, Apellido: Martínez, Edad: 23, Promedio: 92.0
-- ID: 5, Nombre: Carlos, Apellido: López, Edad: 22, Promedio: 86.5
-- Crear la tabla "estudiantes"
CREATE TABLE estudiantes (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    edad INT,
    promedio FLOAT
);
-- Insertar las filas en la tabla "estudiantes"
INSERT INTO estudiantes (id, nombre, apellido, edad, promedio)
VALUES (1, 'Juan', 'Pérez', 22, 85.5),
    (2, 'María', 'Gómez', 21, 90.0),
    (3, 'Luis', 'Rodríguez', 20, 88.5),
    (4, 'Ana', 'Martínez', 23, 92.0),
    (5, 'Carlos', 'López', 22, 86.5);

-- Encuentra la longitud del nombre del estudiante con el nombre "Luis" y apellido "Rodríguez".
SELECT CHAR_LENGTH(CONCAT(e.nombre , ' ', e.apellido)) as longitud_nombre
FROM estudiantes e
WHERE e.nombre = 'Luis' AND e.apellido = 'Rodríguez';

-- Concatena el nombre y el apellido del estudiante con el nombre "María" y apellido "Gómez" con un espacio en el medio. 
SELECT CONCAT(e.nombre , ' ', e.apellido) as nombre_completo
FROM estudiantes e
WHERE e.nombre = 'María' AND e.apellido = 'Gómez';

-- Encuentra la posición de la primera 'e' en el apellido del estudiante con el nombre "Juan" y apellido "Pérez".
SELECT LOCATE('e' , e.apellido) as localizar_e
FROM estudiantes e
WHERE e.nombre = 'Juan' AND e.apellido = 'Pérez';
-------------- O ------------
SELECT POSITION('e' IN e.apellido) as localizar_e
FROM estudiantes e
WHERE e.nombre = 'Juan' AND e.apellido = 'Pérez';

-- Inserta la cadena ' García' en la posición 3 del nombre del estudiante con el nombre "Ana" y apellido "Martínez".
SELECT INSERT(e.nombre, 3, 7,' García') as insertar_garcia
FROM estudiantes e
WHERE e.nombre = 'Juan' AND e.apellido = 'Pérez';

-- Convierte el nombre del estudiante con el nombre "Luis" y apellido "Rodríguez" a minúsculas. (LOWER)
SELECT LOWER(e.nombre) as nombre_minuscula
FROM estudiantes e
WHERE e.nombre = 'Luis' AND e.apellido = 'Rodríguez';

-- Convierte el apellido del estudiante con el nombre "Juan" y apellido "Pérez" a mayúsculas. (UPPER)
SELECT UPPER(e.nombre) as nombre_minuscula
FROM estudiantes e
WHERE e.nombre = 'Juan' AND e.apellido = 'Pérez';

-- Obtiene los primeros 4 caracteres del apellido del estudiante con el nombre "María" y apellido "Gómez". (LEFT)
SELECT LEFT(e.apellido, 4) as obtener_caracteres
FROM estudiantes e
WHERE e.nombre = 'María' AND e.apellido = 'Gómez';

-- Obtiene los últimos 3 caracteres del apellido del estudiante con el nombre "Ana" y apellido "Martínez". (RIGHT)
SELECT RIGHT(e.apellido, 4) as obtener_caracteres
FROM estudiantes e
WHERE e.nombre = 'Ana' AND e.apellido = 'Martínez';

-- Encuentra la posición de la primera 'o' en el nombre del estudiante con el nombre "Carlos" y apellido "López". (LOCATE)
SELECT LOCATE('o' , e.nombre) as localizar_o
FROM estudiantes e
WHERE e.nombre = 'Carlos' AND e.apellido = 'López';

-- Encuentra la posición de la primera aparición de la letra 'a' en el nombre de la estudiante con el nombre "María" y apellido "Gómez".
SELECT POSITION('a' , e.nombre) as localizar_a
FROM estudiantes e
WHERE e.nombre = 'María' AND e.apellido = 'Gómez';

-- Reemplaza 'a' con 'X' en el nombre del estudiante con el nombre "Ana" y apellido "Martínez". 
SELECT REPLACE(e.nombre, 'a', 'X') as remplazar_a
FROM estudiantes e
WHERE e.nombre = 'Ana' AND e.apellido = 'Martínez';

-- Encuentra la subcadena de 3 caracteres de longitud de la columna 'nombre' del estudiante con el nombre "María" y apellido "Gómez", comenzando en la posición 2.
SELECT SUBSTR(e.nombre, 2, 3) as subcadena_3
FROM estudiantes e
WHERE e.nombre = 'María' AND e.apellido = 'Gómez';

-- Combina los nombres de todos los estudiantes en una única cadena separada por guiones con order by.
SELECT GROUP_CONCAT(e.nombre ORDER BY e.nombre ASC SEPARATOR '_') as group_concat
FROM estudiantes e;

-- Combina los nombres y apellidos de todos los estudiantes en una única cadena separada por un guion vertical (|).
SELECT GROUP_CONCAT(CONCAT(e.nombre, e.apellido) SEPARATOR '|') as group_concat
FROM estudiantes e;

-- Elimina los espacios en blanco iniciales del texto "    … usé muchos espacios    ".
SELECT LTRIM('    … usé muchos espacios    .') as quitar_espacios;
---------------- o ----------------
SELECT TRIM(LEADING ' ' FROM '    … usé muchos espacios    .') as quitar_espacios;

-- Elimina los espacios en blanco finales del texto "    … usé muchos espacios    ".
SELECT RTRIM('    … usé muchos espacios    .') as quitar_espacios;
---------------- o ----------------
SELECT TRIM(TRAILING ' ' FROM '    … usé muchos espacios    .') as quitar_espacios;

-- Cita el resultado de los dos ejercicios anteriores utilizando la función QUOTE.
SELECT QUOTE((SELECT TRIM(TRAILING ' ' FROM '    … usé muchos espacios    .') as quitar_espacios)) AS texto_citado_iniciales,
       QUOTE((SELECT TRIM(LEADING ' ' FROM '    … usé muchos espacios    .') as quitar_espacios)) AS texto_citado_finales;

-- Ejercicios con funciones de texto - Parte 2
-- ✏️Ejercicios funciones de texto
-- Repite el nombre y apellido del estudiante con el nombre "Juan" y apellido "Pérez" tres veces. 
SELECT REPEAT(CONCAT(nombre, ' ', apellido), 3) AS repetido
FROM estudiantes
WHERE nombre = 'Juan' AND apellido = 'Pérez';

-- Invierte el nombre del estudiante con el nombre "Ana" y apellido "Martínez". 
SELECT REVERSE(nombre) AS nombre_invertido
FROM estudiantes
WHERE nombre = 'Ana' AND apellido = 'Martínez';

-- Devuelve una cadena que contenga 8 caracteres de espacio usando la función SPACE y muéstrala con la función QUOTE.
SELECT QUOTE(SPACE(8)) AS espacios_con_cita;

-- Extrae una subcadena que contiene el nombre del estudiante con el nombre "María" y apellido "Gómez" antes de la segunda a utilizando SUBSTRING_INDEX.
SELECT SUBSTRING_INDEX(nombre, 'a', 2) AS subcadena_antes_segunda_a
FROM estudiantes
WHERE nombre = 'María' AND apellido = 'Gómez';

-- Combina las edades de todos los estudiantes en una única cadena separada por comas y orden descendente.
SELECT GROUP_CONCAT(edad ORDER BY edad DESC SEPARATOR ',') AS edades_descendentes
FROM estudiantes;

-- Elimina las ‘a’ del nombre' del estudiante con el nombre "Ana" y apellido "Martínez" usando la función REPLACE. 
SELECT REPLACE(nombre, 'a', '') AS nombre_sin_a
FROM estudiantes
WHERE nombre = 'Ana' AND apellido = 'Martínez';

-- Rellena a la derecha el promedio del estudiante con el nombre "Luis" y apellido "Rodríguez" con asteriscos hasta una longitud total de 10 caracteres. 
SELECT RPAD(FORMAT(promedio, 2), 10, '*') AS promedio_rellenado
FROM estudiantes
WHERE nombre = 'Luis' AND apellido = 'Rodríguez';

-- Obtén el promedio del estudiante con nombre 'Carlos' y apellido 'López', formateado con dos decimales y utilizando la configuración regional 'es_AR'.
SELECT FORMAT(promedio, 2, 'es_AR') AS promedio_formateado
FROM estudiantes
WHERE nombre = 'Carlos' AND apellido = 'López';