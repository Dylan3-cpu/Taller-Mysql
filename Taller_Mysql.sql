CREATE DATABASE vtaszfs;
USE vtaszfs;

CREATE TABLE Clients (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE ClientLocation (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_id INT,
  address VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(50),
  postal_code VARCHAR(10),
  country VARCHAR(50),
  FOREIGN KEY (client_id) REFERENCES Clients(id)
) ENGINE=InnoDB;

CREATE TABLE Employees (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  position VARCHAR(50),
  salario DECIMAL(10, 2),
  hire_date DATE
) ENGINE=InnoDB;

CREATE TABLE Suppliers (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  contact VARCHAR(100),
  phone VARCHAR(20),
  address VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE ProductTypes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  type_name VARCHAR(100),
  description TEXT
) ENGINE=InnoDB;

CREATE TABLE Products (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  price DECIMAL(10, 2),
  supplier_id INT,
  tipo_id INT,
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(id),
  FOREIGN KEY (tipo_id) REFERENCES ProductTypes(id)
) ENGINE=InnoDB;

CREATE TABLE Orders (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_id INT,
  date DATE,
  total DECIMAL(10, 2),
  FOREIGN KEY (client_id) REFERENCES Clients(id)
) ENGINE=InnoDB;

CREATE TABLE OrderDetails (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10, 2),
  FOREIGN KEY (order_id) REFERENCES Orders(id),
  FOREIGN KEY (product_id) REFERENCES Products(id)
) ENGINE=InnoDB;

INSERT INTO Clients (name, email) VALUES
('Checo Perez', 'checo_perez@gmail.com'),
('Lirili Larila', 'lila@gmail.com'),
('Lucho Diaz', 'guajiro@gmail.com');

INSERT INTO ClientLocation (client_id, address, city, state, postal_code, country) VALUES
(1, 'Street 101101', 'Bogota', 'Cundinamarca', '110111', 'Colombia'),
(2, 'Avenue 45', 'Medellin', 'Antioquia', '050021', 'Colombia'),
(3, 'Almost There Ave.', 'Cali', 'Valle', '760001', 'Colombia');

INSERT INTO Employees (name, position, salario, hire_date) VALUES
('Ana Torres', 'Salesperson', 2500.00, '2005-01-01'),
('Luis Martinez', 'Manager', 5000.00, '2004-02-02'),
('Sandra Lopez', 'Assistant', 1800.00, '2003-03-03');

INSERT INTO Suppliers (name, contact, phone, address) VALUES
('CarefulElectricity', 'Juan Ruiz', '3001234567', 'Street 10 #15-20'),
('PencilThatWrites', 'Marta Sanchez', '3107654321', 'Ave. 8 #45-32');

INSERT INTO ProductTypes (type_name, description) VALUES
('Electronics', 'Dispositivos electrónicos'),
('Office Supplies', 'Suministros de oficina');

INSERT INTO Products (name, price, supplier_id, tipo_id) VALUES
('Gaming Laptop X95', 3500.00, 1, 1),
('Wireless Mouse Pro', 50.00, 1, 1),
('Premium Paper Ream', 20.00, 2, 2),
('Ballpoint Pens Set x10', 5.00, 2, 2);

INSERT INTO Orders (client_id, date, total) VALUES
(1, '2024-05-10', 70.00),
(2, '2024-05-12', 3500.00),
(3, '2024-05-15', 25.00);

INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES
(1, 2, 1, 50.00), -- Mouse
(1, 4, 2, 10.00), -- Pens
(2, 1, 1, 3500.00), -- Laptop 
(3, 3, 1, 20.00); -- Paper Ream

CREATE TABLE OrderHistory (
  id INT PRIMARY KEY AUTO_INCREMENT,
  order_id INT,
  action VARCHAR(50),
  change_date DATETIME,
  previous_total DECIMAL(10,2),
  new_total DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(id)
) ENGINE=InnoDB;


CREATE TABLE Positions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  position_name VARCHAR(50)
) ENGINE=InnoDB;

INSERT INTO Positions (position_name) VALUES
('Salesperson'), ('Manager'), ('Assistant');

CREATE TABLE EmployeeData (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  puesto_id INT,
  salario DECIMAL(10,2),
  hire_date DATE,
  FOREIGN KEY (puesto_id) REFERENCES Positions(id)
) ENGINE=InnoDB;


CREATE TABLE SupplierContacts (
  id INT PRIMARY KEY AUTO_INCREMENT,
  supplier_id INT,
  contact VARCHAR(100),
  phone VARCHAR(20),
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
) ENGINE=InnoDB;


CREATE TABLE ClientPhones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_id INT,
  phone VARCHAR(20),
  FOREIGN KEY (client_id) REFERENCES Clients(id)
) ENGINE=InnoDB;


ALTER TABLE ProductTypes
ADD COLUMN tipo_padre_id INT NULL,
ADD FOREIGN KEY (tipo_padre_id) REFERENCES ProductTypes(id);



CREATE TABLE EmployeeSupplier (
  id INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INT,
  supplier_id INT,
  FOREIGN KEY (employee_id) REFERENCES Employees(id),
  FOREIGN KEY (supplier_id) REFERENCES Suppliers(id)
) ENGINE=InnoDB;


CREATE TABLE Locations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  address VARCHAR(255),
  city VARCHAR(100),
  state VARCHAR(50),
  postal_code VARCHAR(10),
  country VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE ClientAddress (
  id INT PRIMARY KEY AUTO_INCREMENT,
  client_id INT,
  ubicacion_id INT,
  FOREIGN KEY (client_id) REFERENCES Clients(id),
  FOREIGN KEY (ubicacion_id) REFERENCES Locations(id)
) ENGINE=InnoDB;




SELECT 
    p.id as order_id,
    p.date,
    p.total,
    c.name as client_name,
    c.email
FROM Orders p
INNER JOIN Clients c ON p.client_id = c.id;

SELECT 
    prod.id as product_id,
    prod.name as product_name,
    prod.price,
    prov.name as supplier_name,
    prov.contact
FROM Products prod
INNER JOIN Suppliers prov ON prod.supplier_id = prov.id;

SELECT 
    p.id as order_id,
    p.date,
    p.total,
    c.name as client_name,
    uc.address,
    uc.city,
    uc.state,
    uc.country
FROM Orders p
INNER JOIN Clients c ON p.client_id = c.id
LEFT JOIN ClientLocation uc ON c.id = uc.client_id;

ALTER TABLE Orders ADD COLUMN employee_id INT;
ALTER TABLE Orders ADD FOREIGN KEY (employee_id) REFERENCES Employees(id);

UPDATE Orders SET employee_id = 1 WHERE id = 1;
UPDATE Orders SET employee_id = 2 WHERE id = 2;
UPDATE Orders SET employee_id = 1 WHERE id = 3;

SELECT 
    e.id as employee_id,
    e.name as employee_name,
    e.position,
    p.id as order_id,
    p.date,
    p.total
FROM Employees e
LEFT JOIN Orders p ON e.id = p.employee_id;

SELECT 
    tp.id as tipo_id,
    tp.type_name,
    tp.description,
    prod.id as product_id,
    prod.name as product_name,
    prod.price
FROM ProductTypes tp
INNER JOIN Products prod ON tp.id = prod.tipo_id;

SELECT 
    c.id as client_id,
    c.name as client_name,
    c.email,
    COUNT(p.id) as number_of_orders
FROM Clients c
LEFT JOIN Orders p ON c.id = p.client_id
GROUP BY c.id, c.name, c.email;

SELECT 
    e.name as employee_name,
    e.position,
    p.id as order_id,
    p.date,
    p.total,
    c.name as client_name
FROM Employees e
INNER JOIN Orders p ON e.id = p.employee_id
INNER JOIN Clients c ON p.client_id = c.id;

SELECT 
    prod.id as product_id,
    prod.name as product_name,
    prod.price,
    dp.product_id as pedido_producto_id
FROM OrderDetails dp
RIGHT JOIN Products prod ON dp.product_id = prod.id
WHERE dp.product_id IS NULL;

SELECT 
    c.name as client_name,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as total_order_value,
    uc.address,
    uc.city,
    uc.state
FROM Clients c
LEFT JOIN Orders p ON c.id = p.client_id
LEFT JOIN ClientLocation uc ON c.id = uc.client_id
GROUP BY c.id, c.name, uc.address, uc.city, uc.state;

SELECT 
    prov.name as supplier_name,
    prov.contact,
    tp.type_name,
    prod.name as product_name,
    prod.price,
    FLOOR(RAND() * 100) + 1 as available_stock
FROM Suppliers prov
INNER JOIN Products prod ON prov.id = prod.supplier_id
INNER JOIN ProductTypes tp ON prod.tipo_id = tp.id
ORDER BY prov.name, tp.type_name;




SELECT 
    id,
    name,
    price,
    supplier_id,
    tipo_id
FROM Products
WHERE price > 50;

SELECT 
    c.id,
    c.name,
    c.email,
    uc.city
FROM Clients c
INNER JOIN ClientLocation uc ON c.id = uc.client_id
WHERE uc.city = 'Bogota';


SELECT 
    id,
    name,
    position,
    salario,
    hire_date
FROM Employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

SELECT 
    prov.id,
    prov.name,
    prov.contact,
    COUNT(prod.id) as total_productos
FROM Suppliers prov
INNER JOIN Products prod ON prov.id = prod.supplier_id
GROUP BY prov.id, prov.name, prov.contact
HAVING COUNT(prod.id) > 5;

SELECT 
    c.id,
    c.name,
    c.email
FROM Clients c
LEFT JOIN ClientLocation uc ON c.id = uc.client_id
WHERE uc.client_id IS NULL;

SELECT 
    c.id as client_id,
    c.name as client_name,
    c.email,
    COALESCE(SUM(p.total), 0) as total_sales
FROM Clients c
LEFT JOIN Orders p ON c.id = p.client_id
GROUP BY c.id, c.name, c.email;

SELECT 
    ROUND(AVG(salario), 2) as average_salary,
    COUNT(*) as total_empleados,
    MIN(salario) as minimum_salary,
    MAX(salario) as maximum_salary
FROM Employees;

SELECT 
    id,
    type_name,
    description
FROM ProductTypes
ORDER BY type_name;

SELECT 
    id,
    name,
    price,
    supplier_id
FROM Products
ORDER BY price DESC
LIMIT 3;

SELECT 
    c.id as client_id,
    c.name as client_name,
    c.email,
    COUNT(p.id) as number_of_orders
FROM Clients c
INNER JOIN Orders p ON c.id = p.client_id
GROUP BY c.id, c.name, c.email
ORDER BY number_of_orders DESC
LIMIT 1;




SELECT 
    p.id as order_id,
    p.date,
    p.total,
    c.id as client_id,
    c.name as client_name,
    c.email
FROM Orders p
INNER JOIN Clients c ON p.client_id = c.id
ORDER BY p.date DESC;

SELECT 
    p.id as order_id,
    p.date,
    p.total,
    c.name as client_name,
    uc.address,
    uc.city,
    uc.state,
    uc.postal_code,
    uc.country
FROM Orders p
INNER JOIN Clients c ON p.client_id = c.id
LEFT JOIN ClientLocation uc ON c.id = uc.client_id
ORDER BY p.date DESC;

SELECT 
    prod.id as product_id,
    prod.name as product_name,
    prod.price,
    prov.name as supplier_name,
    prov.contact as contacto_proveedor,
    tp.type_name,
    tp.description as descripcion_tipo
FROM Products prod
INNER JOIN Suppliers prov ON prod.supplier_id = prov.id
INNER JOIN ProductTypes tp ON prod.tipo_id = tp.id
ORDER BY tp.type_name, prod.name;

SELECT DISTINCT
    e.id as employee_id,
    e.name as employee_name,
    e.position,
    c.name as client_name,
    uc.city
FROM Employees e
INNER JOIN Orders p ON e.id = p.employee_id
INNER JOIN Clients c ON p.client_id = c.id
INNER JOIN ClientLocation uc ON c.id = uc.client_id
WHERE uc.city = 'Bogota';

SELECT 
    prod.id as product_id,
    prod.name as product_name,
    prod.price,
    SUM(dp.quantity) as total_vendido,
    COUNT(dp.id) as times_ordered
FROM Products prod
INNER JOIN OrderDetails dp ON prod.id = dp.product_id
GROUP BY prod.id, prod.name, prod.price
ORDER BY total_vendido DESC
LIMIT 5;

SELECT 
    c.name as client_name,
    uc.city,
    uc.state,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as total_value
FROM Clients c
INNER JOIN ClientLocation uc ON c.id = uc.client_id
LEFT JOIN Orders p ON c.id = p.client_id
GROUP BY c.id, c.name, uc.city, uc.state
ORDER BY total_pedidos DESC;

SELECT 
    'Client' as type,
    c.name,
    uc.city
FROM Clients c
INNER JOIN ClientLocation uc ON c.id = uc.client_id
UNION ALL
SELECT 
    'Supplier' as type,
    p.name,
    CASE 
        WHEN p.address LIKE '%Street 10%' THEN 'Bogota'
        WHEN p.address LIKE '%Ave. 8%' THEN 'Medellin'
        ELSE 'Other city'
    END as city
FROM Suppliers p
ORDER BY city, type, name;

SELECT 
    tp.type_name,
    tp.description,
    COUNT(dp.id) as products_sold,
    SUM(dp.quantity) as total_quantity,
    SUM(dp.quantity * dp.price) as total_sales
FROM ProductTypes tp
INNER JOIN Products prod ON tp.id = prod.tipo_id
INNER JOIN OrderDetails dp ON prod.id = dp.product_id
GROUP BY tp.id, tp.type_name, tp.description
ORDER BY total_sales DESC;

SELECT DISTINCT
    e.name as employee_name,
    e.position,
    prov.name as supplier_name,
    prod.name as product_name,
    p.date as order_date,
    dp.quantity
FROM Employees e
INNER JOIN Orders p ON e.id = p.employee_id
INNER JOIN OrderDetails dp ON p.id = dp.order_id
INNER JOIN Products prod ON dp.product_id = prod.id
INNER JOIN Suppliers prov ON prod.supplier_id = prov.id
WHERE prov.name = 'CarefulElectricity'
ORDER BY p.date DESC;

SELECT 
    prov.id as supplier_id,
    prov.name as supplier_name,
    prov.contact,
    COUNT(DISTINCT prod.id) as products_offered,
    COUNT(dp.id) as total_sales,
    SUM(dp.quantity) as units_sold,
    SUM(dp.quantity * dp.price) as total_revenue
FROM Suppliers prov
INNER JOIN Products prod ON prov.id = prod.supplier_id
LEFT JOIN OrderDetails dp ON prod.id = dp.product_id
GROUP BY prov.id, prov.name, prov.contact
ORDER BY total_revenue DESC;