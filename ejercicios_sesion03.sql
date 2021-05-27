# Ejercicios sesión 03
USE classicmodels;

# 1. Obtén la cantidad de productos de cada orden.
SELECT o.orderNumber, sum(od.quantityOrdered) cantidad_productos
FROM orderdetails AS od
INNER JOIN orders AS o
ON od.orderNumber = o.orderNumber
GROUP BY o.orderNumber
ORDER BY orderNumber;

# 2. Obtén el número de orden, estado y costo total de cada orden.
SELECT od.orderNumber, o.status, round(sum(od.quantityOrdered * od.priceEach), 2) costo_total
FROM orderdetails AS od
JOIN orders AS o
ON od.orderNumber = o.orderNumber
GROUP BY od.orderNumber
ORDER BY od.orderNumber;

# 3. Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
SELECT o.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
FROM orderdetails AS od
JOIN products AS p
ON od.productCode = p.productCode
JOIN orders AS o
ON od.orderNumber = o.orderNumber
ORDER BY o.orderNumber;

# 4. Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
SELECT od.orderNumber, p.productName, p.MSRP, od.priceEach
FROM orderdetails AS od
INNER JOIN products AS p
ON od.productCode = p.productCode
ORDER BY od.orderNumber;

/* 5. Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. 
¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
R. Porque así nos aseguramos de que nos traiga todos y cada uno de los registros que solicitemos de la 
primer tabla que seleccionemos, sin importar si esta tiene alguna conexión con la segunda tabla en la consulta. */
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber;

# 6. Obtén los clientes que no tienen una orden asociada.
SELECT c.customerNumber, c.customerName
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL
ORDER BY c.customerNumber;

# 7. Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM employees AS e
LEFT JOIN customers AS c
ON  e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE customerName IS NOT NULL
ORDER BY c.customerName, p.checkNumber;

# 8. Repite los ejercicios 5 a 7 usando RIGHT JOIN. 
# ¿Representan lo mismo? Explica las diferencias en un comentario. Para poner comentarios usa --.

-- No representan lo mismo, cambiará si las tablas se encuentran en el mismo lugar, en otras palabras, si la tabla A en LEFT JOIN se mantiene como tabla A en RIGHT JOIN no se traerán todos los registros de la tabla A en el RIGHT JOIN; por lo tanto, los resultados pueden cambiar.
-- En el RIGHT JOIN se traerán todos los resultados de la tabla B sin importar que tengan una relación con los de la tabla A, y en el caso de estos registros se completará con valores 'NULL'

# 8.5 Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente.
SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM orders AS o
RIGHT JOIN customers AS c
ON c.customerNumber = o.customerNumber;

# 8.6 Obtén los clientes que no tienen una orden asociada.
SELECT c.customerNumber, c.customerName
FROM orders AS o
RIGHT JOIN customers AS c
ON c.customerNumber = o.customerNumber
WHERE o.orderNumber IS NULL
ORDER BY c.customerNumber;

# 8.7 Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
SELECT e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM payments AS p
RIGHT JOIN customers AS c
ON  c.customerNumber = p.customerNumber
RIGHT JOIN employees AS e
ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE customerName IS NOT NULL
ORDER BY c.customerName, p.checkNumber;

# 9. Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
-- Ejercicio 3. 
CREATE VIEW ejercicio_3_708 AS
(SELECT o.orderNumber, o.orderDate, od.orderLineNumber, p.productName, od.quantityOrdered, od.priceEach
FROM orderdetails AS od
JOIN products AS p
ON od.productCode = p.productCode
JOIN orders AS o
ON od.orderNumber = o.orderNumber
ORDER BY o.orderNumber);

SELECT *
FROM ejercicio_3_708;

-- Ejercicio 5.
CREATE VIEW ejercicio_5_708 AS
(SELECT c.customerNumber, c.customerName, o.orderNumber, o.status
FROM customers AS c
LEFT JOIN orders AS o
ON c.customerNumber = o.customerNumber);

SELECT *
FROM ejercicio_5_708;

-- Ejercicio 7.
CREATE VIEW ejercicio_7_708 AS
(SELECT e.lastName, e.firstName, c.customerName, p.checkNumber, p.amount
FROM employees AS e
LEFT JOIN customers AS c
ON  e.employeeNumber = c.salesRepEmployeeNumber
LEFT JOIN payments AS p
ON c.customerNumber = p.customerNumber
WHERE customerName IS NOT NULL
ORDER BY c.customerName, p.checkNumber);

SELECT *
FROM ejercicio_7_708
ORDER BY customerName;