USE classicmodels;

# 1. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con A.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'A%';

# 2. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE lastName LIKE '%on';

# 3. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE '%on%';

# 4. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName LIKE 'G_____';

# 5. Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
SELECT employeeNumber, lastName, firstName
FROM employees
WHERE firstName NOT LIKE 'B%';

# 6. Dentro de la tabla products, obtén el código de producto y nombre de los productos cuyo código incluye la cadena _20.
SELECT productCode, productName
FROM products
WHERE productCode LIKE '%\_20%';

# 7. Dentro de la tabla orderdetails, obtén el total de cada orden.
SELECT orderNumber, sum(quantityOrdered * priceEach) total
FROM orderdetails
GROUP BY orderNumber
ORDER BY orderNumber;

# 8. Dentro de la tabla orders obtén el número de órdenes por año.
SELECT year(orderDate) año, count(*) ordenes_año
FROM orders
GROUP BY año;

# 9. Obtén el apellido y nombre de los empleados cuya oficina está ubicada en USA.
SELECT lastName, firstName
FROM employees AS e
WHERE officeCode IN 
	(SELECT officeCode 
    FROM offices 
    WHERE country = 'USA');
    
# 10. Obtén el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount = (SELECT max(amount) FROM payments);

# 11. Obtén el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT avg(amount) FROM payments)
ORDER BY amount;

# 12. Obtén el nombre de aquellos clientes que no han hecho ninguna orden.
SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT customerNumber FROM orders);

# 13. Obtén el máximo, mínimo y promedio del número de productos en las órdenes de venta.
SELECT max(quantityOrdered) max, min(quantityOrdered) min, avg(quantityOrdered) promedio
FROM orderdetails;

# 14. Dentro de la tabla orders, Obtén el número de órdenes que hay por cada estado.
SELECT status, count(*)
FROM orders
GROUP BY status;