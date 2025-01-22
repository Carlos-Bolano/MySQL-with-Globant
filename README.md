# 📚 Apuntes y Ejercicios de SQL – Curso de Backend con Java en Globant University.

Bienvenido a este repositorio, donde encontrarás mis **apuntes y ejercicios prácticos de SQL** realizados durante el módulo de SQL en mi curso de backend con Java en Globant University. 💻 El archivo `db.sql` incluye una amplia variedad de comandos SQL utilizados desde la primera clase para **crear, manipular y consultar bases de datos**, con ejemplos claros y bien documentados. 📋

---

## 🛠️ Comandos SQL Utilizados

A continuación, un resumen de los **comandos SQL más importantes** que aparecen en los apuntes y ejercicios:

- 🗃️ **`CREATE DATABASE`** – Crear bases de datos.
- ❌ **`DROP DATABASE`** – Eliminar bases de datos.
- 📂 **`USE`** – Seleccionar la base de datos que se va a utilizar.
- 📋 **`CREATE TABLE`** – Crear tablas con diversas columnas y restricciones.
- 🛠️ **`ALTER TABLE`** – Modificar tablas existentes para añadir o eliminar columnas, o cambiar restricciones.
- ➕ **`ADD`** – Añadir nuevas columnas a tablas existentes.
- ✏️ **`MODIFY`** – Modificar columnas existentes.
- 📝 **`INSERT INTO`** – Insertar datos en las tablas.
- 🔍 **`SELECT`** – Realizar consultas para obtener datos de las tablas.
- 🔄 **`UPDATE`** – Actualizar datos existentes en las tablas.
- 🗑️ **`DELETE`** – Eliminar datos de las tablas.
- 🔗 **`JOIN`** – Realizar combinaciones entre tablas.
- 🏷️ **`DISTINCT`** – Obtener valores únicos en las consultas.
- 🔑 **`PRIMARY KEY`** – Definir claves primarias en tablas.
- 🚀 **`AUTO_INCREMENT`** – Automatizar el incremento de valores en columnas.
- 🚫 **`NOT NULL`** – Establecer que las columnas no permitan valores nulos.
- 🛠️ **`DEFAULT`** – Definir valores predeterminados para columnas.
- 🔐 **`FOREIGN KEY`** – Definir claves foráneas para relaciones entre tablas.
- 📊 **`ORDER BY`** – Ordenar los resultados de las consultas.
- 📋 **`GROUP BY`** – Agrupar los resultados de las consultas.
- ⚙️ **`HAVING`** – Filtrar resultados de grupos.

### 📈 Funciones de Agregación

- 🏆 **`MAX`** – Obtener el valor máximo de una columna.
- 📉 **`MIN`** – Obtener el valor mínimo de una columna.
- ➕ **`SUM`** – Calcular la suma de valores en una columna.
- 📊 **`AVG`** – Calcular el promedio de valores en una columna.
- 🔢 **`COUNT`** – Contar el número de filas que cumplen una condición.

### 🔍 Funciones de Formato y Manipulación de Datos

- 🔤 **`LOWER`** – Convertir texto a minúsculas.
- 🔠 **`UPPER`** – Convertir texto a mayúsculas.
- 🔎 **`SUBSTRING`** – Extraer una subcadena de una cadena de texto.
- 🧮 **`CHAR_LENGTH`** – Obtener la longitud de una cadena de texto.
- ✂️ **`TRIM`** – Eliminar espacios en blanco de los extremos de una cadena.

- 🔢 **`FORMAT`** – Formatear números con separadores de miles y decimales.
  - Ejemplo: `FORMAT(1234567.89, 2)` → `1,234,567.89`
- 🎯 **`ROUND`** – Redondear números al número de decimales especificado.
- 💯 **`DECIMAL`** – Especificar la cantidad de dígitos antes y después del punto decimal en una columna o cálculo.
- 🗓️ **`DATE_FORMAT`** – Dar formato a las fechas en consultas.
  - Ejemplo: `DATE_FORMAT('2023-01-15', '%d-%m-%Y')` → `15-01-2023`
- 🕒 **`TIME_FORMAT`** – Formatear datos de tipo hora.
- 🔡 **`CONCAT`** – Combinar valores de múltiples columnas en una sola cadena.
  - Ejemplo: `CONCAT('Hola', ' ', 'Mundo')` → `Hola Mundo`

---

## 📖 Descripción de los Ejercicios

Los ejercicios abarcan los siguientes temas fundamentales:

1. 🗃️ **Creación y eliminación de bases de datos.**
2. 📋 **Creación y modificación de tablas.**
3. 📝 **Inserción, actualización y eliminación de datos.**
4. 🔍 **Consultas básicas y avanzadas utilizando `SELECT`.**
5. 🔗 **Joins y relaciones entre tablas.**
6. 🔑 **Uso de restricciones como `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, y `DEFAULT`.**
7. 📊 **Ordenamiento y agrupamiento de datos.**

---

## 📝 Clases Cubiertas Hasta el Momento

El archivo `db.sql` refleja el contenido cubierto hasta ahora en el curso, las clases abordadas incluyen:

1. **Base de datos Relacionales - MySQL: Primeros pasos con MySQL**

   - Introducción a los conceptos básicos de bases de datos relacionales.
   - Uso de MySQL como Sistema de Gestión de Bases de Datos (SGBD).

2. **Base de datos Relacionales - MySQL: Lenguaje DDL Y DML**

   - Lenguaje de definición de datos (DDL) para crear y modificar la estructura de la base de datos.
   - Lenguaje de manipulación de datos (DML) para insertar, actualizar y eliminar datos.

3. **Base de datos Relacionales - MySQL: Comando Select**

   - Uso básico del comando `SELECT` para consultar datos de la base de datos.

4. **Base de datos Relacionales - MySQL: Avanzando con el uso de la cláusula Select**

   - Técnicas avanzadas con `SELECT`: funciones de agregación, subconsultas y cláusulas `WHERE` complejas.

5. **Base de datos Relacionales - MySQL: Consultas multitablas**

   - Consultas que involucran múltiples tablas utilizando uniones pero sin usar (`JOIN`).

6. **Base de datos Relacionales - MySQL: Introducción a los JOIN en MySQL**

   - Uso de las uniones (`JOIN`) para combinar datos de múltiples tablas en una consulta, explorando los diferentes tipos de uniones como `INNER JOIN`, `LEFT JOIN`, y `RIGHT JOIN`

7. **Base de datos Relacionales - MySQL: USO de Tablas Temporales**

   - Introducción a las tablas temporales y su uso en consultas complejas.
   - Ejercicios prácticos con `CREATE TEMPORARY TABLE`, consultas sobre tablas temporales, y eliminación de tablas temporales con `DROP TEMPORARY TABLE`.

8. **Base de datos Relacionales - MySQL: Funciones de Texto**

   - Uso de funciones de texto como `LOWER`, `UPPER`, `SUBSTRING`, `CHAR_LENGTH`, y `TRIM`.
   - Ejercicios prácticos para manipular cadenas y realizar consultas avanzadas.

---

## 🎯 Objetivo del Repositorio

Este repositorio ha sido creado como una **herramienta de apoyo y referencia personal** para reforzar los conceptos aprendidos durante el curso de backend, además de servir como **punto de partida** para proyectos que requieran bases de datos SQL.

El archivo `db.sql` tiene como principal propósito ayudar a los compañeros que aún no están al día con las clases. 📥 Pueden **descargar y ejecutar este archivo en sus máquinas locales** para tener una base de datos completamente actualizada hasta la última clase. 🖥️

💡 De esta forma, podrán comenzar cada lección con una base de datos al día y enfocarse en los nuevos temas que se enseñen en clase.

El objetivo es **fomentar el aprendizaje colaborativo**, asegurando que todos los compañeros puedan avanzar juntos y aprovechar al máximo cada lección del curso. 🤝📚
