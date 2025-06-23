CREATE DATABASE vtaszfs;
USE vtaszfs;

CREATE TABLE Clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  email VARCHAR(100) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE UbicacionCliente (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  direccion VARCHAR(255),
  ciudad VARCHAR(100),
  estado VARCHAR(50),
  codigo_postal VARCHAR(10),
  pais VARCHAR(50),
  FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
) ENGINE=InnoDB;

CREATE TABLE Empleados (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  puesto VARCHAR(50),
  salario DECIMAL(10, 2),
  fecha_contratacion DATE
) ENGINE=InnoDB;

CREATE TABLE Proveedores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  contacto VARCHAR(100),
  telefono VARCHAR(20),
  direccion VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE TiposProductos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  tipo_nombre VARCHAR(100),
  descripcion TEXT
) ENGINE=InnoDB;

CREATE TABLE Productos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  precio DECIMAL(10, 2),
  proveedor_id INT,
  tipo_id INT,
  FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id),
  FOREIGN KEY (tipo_id) REFERENCES TiposProductos(id)
) ENGINE=InnoDB;

CREATE TABLE Pedidos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  fecha DATE,
  total DECIMAL(10, 2),
  FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
) ENGINE=InnoDB;

CREATE TABLE DetallesPedido (
  id INT PRIMARY KEY AUTO_INCREMENT,
  pedido_id INT,
  producto_id INT,
  cantidad INT,
  precio DECIMAL(10, 2),
  FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
  FOREIGN KEY (producto_id) REFERENCES Productos(id)
) ENGINE=InnoDB;

INSERT INTO Clientes (nombre, email) VALUES
('Checo Pérez', 'checo_perez@gmail.com'),
('Lirili Larila', 'lila@gmail.com'),
('Lucho Díaz', 'guajiro@gmail.com');

INSERT INTO UbicacionCliente (cliente_id, direccion, ciudad, estado, codigo_postal, pais) VALUES
(1, 'Calle 101101', 'Bogotá', 'Cundinamarca', '110111', 'Colombia'),
(2, 'Carrera 45', 'Medellín', 'Antioquia', '050021', 'Colombia'),
(3, 'Av. Ya casi llega', 'Cali', 'Valle', '760001', 'Colombia');

INSERT INTO Empleados (nombre, puesto, salario, fecha_contratacion) VALUES
('Ana Torres', 'Vendedor', 2500.00, '2005-01-01'),
('Luis Martínez', 'Gerente', 5000.00, '2004-02-02'),
('Sandra López', 'Asistente', 1800.00, '2003-03-03');

INSERT INTO Proveedores (nombre, contacto, telefono, direccion) VALUES
('CuidadoElectricidad', 'Juan Ruiz', '3001234567', 'Calle 10 #15-20'),
('LapizQueRaya', 'Marta Sánchez', '3107654321', 'Cra 8 #45-32');

INSERT INTO TiposProductos (tipo_nombre, descripcion) VALUES
('Electrónica', 'Dispositivos electrónicos'),
('Oficina', 'Suministros de oficina');

INSERT INTO Productos (nombre, precio, proveedor_id, tipo_id) VALUES
('Laptop 95 MQUEEN', 3500.00, 1, 1),
('Mouse de Mickey Mouse', 50.00, 1, 1),
('Resma de papel', 20.00, 2, 2),
('Lapiceros x10 de 10', 5.00, 2, 2);

INSERT INTO Pedidos (cliente_id, fecha, total) VALUES
(1, '2024-05-10', 70.00),
(2, '2024-05-12', 3500.00),
(3, '2024-05-15', 25.00);

INSERT INTO DetallesPedido (pedido_id, producto_id, cantidad, precio) VALUES
(1, 2, 1, 50.00), -- Mouse
(1, 4, 2, 10.00), -- Lapiceros
(2, 1, 1, 3500.00), -- Laptop 
(3, 3, 1, 20.00); -- Resma

CREATE TABLE HistorialPedidos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  pedido_id INT,
  accion VARCHAR(50),
  fecha_cambio DATETIME,
  total_anterior DECIMAL(10,2),
  total_nuevo DECIMAL(10,2),
  FOREIGN KEY (pedido_id) REFERENCES Pedidos(id)
) ENGINE=InnoDB;


CREATE TABLE Puestos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_puesto VARCHAR(50)
) ENGINE=InnoDB;

INSERT INTO Puestos (nombre_puesto) VALUES
('Vendedor'), ('Gerente'), ('Asistente');

CREATE TABLE DatosEmpleados (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  puesto_id INT,
  salario DECIMAL(10,2),
  fecha_contratacion DATE,
  FOREIGN KEY (puesto_id) REFERENCES Puestos(id)
) ENGINE=InnoDB;


CREATE TABLE ContactoProveedores (
  id INT PRIMARY KEY AUTO_INCREMENT,
  proveedor_id INT,
  contacto VARCHAR(100),
  telefono VARCHAR(20),
  FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
) ENGINE=InnoDB;


CREATE TABLE TelefonosCliente (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  telefono VARCHAR(20),
  FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
) ENGINE=InnoDB;


ALTER TABLE TiposProductos
ADD COLUMN tipo_padre_id INT NULL,
ADD FOREIGN KEY (tipo_padre_id) REFERENCES TiposProductos(id);



CREATE TABLE EmpleadoProveedor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  empleado_id INT,
  proveedor_id INT,
  FOREIGN KEY (empleado_id) REFERENCES Empleados(id),
  FOREIGN KEY (proveedor_id) REFERENCES Proveedores(id)
) ENGINE=InnoDB;


CREATE TABLE Ubicaciones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  direccion VARCHAR(255),
  ciudad VARCHAR(100),
  estado VARCHAR(50),
  codigo_postal VARCHAR(10),
  pais VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE ClienteUbicacion (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cliente_id INT,
  ubicacion_id INT,
  FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
  FOREIGN KEY (ubicacion_id) REFERENCES Ubicaciones(id)
) ENGINE=InnoDB;




SELECT 
    p.id as pedido_id,
    p.fecha,
    p.total,
    c.nombre as cliente_nombre,
    c.email
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id;

SELECT 
    prod.id as producto_id,
    prod.nombre as producto_nombre,
    prod.precio,
    prov.nombre as proveedor_nombre,
    prov.contacto
FROM Productos prod
INNER JOIN Proveedores prov ON prod.proveedor_id = prov.id;

SELECT 
    p.id as pedido_id,
    p.fecha,
    p.total,
    c.nombre as cliente_nombre,
    uc.direccion,
    uc.ciudad,
    uc.estado,
    uc.pais
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente uc ON c.id = uc.cliente_id;

ALTER TABLE Pedidos ADD COLUMN empleado_id INT;
ALTER TABLE Pedidos ADD FOREIGN KEY (empleado_id) REFERENCES Empleados(id);

UPDATE Pedidos SET empleado_id = 1 WHERE id = 1;
UPDATE Pedidos SET empleado_id = 2 WHERE id = 2;
UPDATE Pedidos SET empleado_id = 1 WHERE id = 3;

SELECT 
    e.id as empleado_id,
    e.nombre as empleado_nombre,
    e.puesto,
    p.id as pedido_id,
    p.fecha,
    p.total
FROM Empleados e
LEFT JOIN Pedidos p ON e.id = p.empleado_id;

SELECT 
    tp.id as tipo_id,
    tp.tipo_nombre,
    tp.descripcion,
    prod.id as producto_id,
    prod.nombre as producto_nombre,
    prod.precio
FROM TiposProductos tp
INNER JOIN Productos prod ON tp.id = prod.tipo_id;

SELECT 
    c.id as cliente_id,
    c.nombre as cliente_nombre,
    c.email,
    COUNT(p.id) as numero_pedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email;

SELECT 
    e.nombre as empleado_nombre,
    e.puesto,
    p.id as pedido_id,
    p.fecha,
    p.total,
    c.nombre as cliente_nombre
FROM Empleados e
INNER JOIN Pedidos p ON e.id = p.empleado_id
INNER JOIN Clientes c ON p.cliente_id = c.id;

SELECT 
    prod.id as producto_id,
    prod.nombre as producto_nombre,
    prod.precio,
    dp.producto_id as pedido_producto_id
FROM DetallesPedido dp
RIGHT JOIN Productos prod ON dp.producto_id = prod.id
WHERE dp.producto_id IS NULL;

SELECT 
    c.nombre as cliente_nombre,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as valor_total_pedidos,
    uc.direccion,
    uc.ciudad,
    uc.estado
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
LEFT JOIN UbicacionCliente uc ON c.id = uc.cliente_id
GROUP BY c.id, c.nombre, uc.direccion, uc.ciudad, uc.estado;

SELECT 
    prov.nombre as proveedor_nombre,
    prov.contacto,
    tp.tipo_nombre,
    prod.nombre as producto_nombre,
    prod.precio,
    FLOOR(RAND() * 100) + 1 as stock_disponible
FROM Proveedores prov
INNER JOIN Productos prod ON prov.id = prod.proveedor_id
INNER JOIN TiposProductos tp ON prod.tipo_id = tp.id
ORDER BY prov.nombre, tp.tipo_nombre;




SELECT 
    id,
    nombre,
    precio,
    proveedor_id,
    tipo_id
FROM Productos
WHERE precio > 50;

SELECT 
    c.id,
    c.nombre,
    c.email,
    uc.ciudad
FROM Clientes c
INNER JOIN UbicacionCliente uc ON c.id = uc.cliente_id
WHERE uc.ciudad = 'Bogotá';


SELECT 
    id,
    nombre,
    puesto,
    salario,
    fecha_contratacion
FROM Empleados
WHERE fecha_contratacion >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);

SELECT 
    prov.id,
    prov.nombre,
    prov.contacto,
    COUNT(prod.id) as total_productos
FROM Proveedores prov
INNER JOIN Productos prod ON prov.id = prod.proveedor_id
GROUP BY prov.id, prov.nombre, prov.contacto
HAVING COUNT(prod.id) > 5;

SELECT 
    c.id,
    c.nombre,
    c.email
FROM Clientes c
LEFT JOIN UbicacionCliente uc ON c.id = uc.cliente_id
WHERE uc.cliente_id IS NULL;

SELECT 
    c.id as cliente_id,
    c.nombre as cliente_nombre,
    c.email,
    COALESCE(SUM(p.total), 0) as total_ventas
FROM Clientes c
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email;

SELECT 
    ROUND(AVG(salario), 2) as salario_promedio,
    COUNT(*) as total_empleados,
    MIN(salario) as salario_minimo,
    MAX(salario) as salario_maximo
FROM Empleados;

SELECT 
    id,
    tipo_nombre,
    descripcion
FROM TiposProductos
ORDER BY tipo_nombre;

SELECT 
    id,
    nombre,
    precio,
    proveedor_id
FROM Productos
ORDER BY precio DESC
LIMIT 3;

SELECT 
    c.id as cliente_id,
    c.nombre as cliente_nombre,
    c.email,
    COUNT(p.id) as numero_pedidos
FROM Clientes c
INNER JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.email
ORDER BY numero_pedidos DESC
LIMIT 1;




SELECT 
    p.id as pedido_id,
    p.fecha,
    p.total,
    c.id as cliente_id,
    c.nombre as cliente_nombre,
    c.email
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
ORDER BY p.fecha DESC;

SELECT 
    p.id as pedido_id,
    p.fecha,
    p.total,
    c.nombre as cliente_nombre,
    uc.direccion,
    uc.ciudad,
    uc.estado,
    uc.codigo_postal,
    uc.pais
FROM Pedidos p
INNER JOIN Clientes c ON p.cliente_id = c.id
LEFT JOIN UbicacionCliente uc ON c.id = uc.cliente_id
ORDER BY p.fecha DESC;

SELECT 
    prod.id as producto_id,
    prod.nombre as producto_nombre,
    prod.precio,
    prov.nombre as proveedor_nombre,
    prov.contacto as contacto_proveedor,
    tp.tipo_nombre,
    tp.descripcion as descripcion_tipo
FROM Productos prod
INNER JOIN Proveedores prov ON prod.proveedor_id = prov.id
INNER JOIN TiposProductos tp ON prod.tipo_id = tp.id
ORDER BY tp.tipo_nombre, prod.nombre;

SELECT DISTINCT
    e.id as empleado_id,
    e.nombre as empleado_nombre,
    e.puesto,
    c.nombre as cliente_nombre,
    uc.ciudad
FROM Empleados e
INNER JOIN Pedidos p ON e.id = p.empleado_id
INNER JOIN Clientes c ON p.cliente_id = c.id
INNER JOIN UbicacionCliente uc ON c.id = uc.cliente_id
WHERE uc.ciudad = 'Bogotá';

SELECT 
    prod.id as producto_id,
    prod.nombre as producto_nombre,
    prod.precio,
    SUM(dp.cantidad) as total_vendido,
    COUNT(dp.id) as veces_pedido
FROM Productos prod
INNER JOIN DetallesPedido dp ON prod.id = dp.producto_id
GROUP BY prod.id, prod.nombre, prod.precio
ORDER BY total_vendido DESC
LIMIT 5;

SELECT 
    c.nombre as cliente_nombre,
    uc.ciudad,
    uc.estado,
    COUNT(p.id) as total_pedidos,
    SUM(p.total) as valor_total
FROM Clientes c
INNER JOIN UbicacionCliente uc ON c.id = uc.cliente_id
LEFT JOIN Pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, uc.ciudad, uc.estado
ORDER BY total_pedidos DESC;

SELECT 
    'Cliente' as tipo,
    c.nombre,
    uc.ciudad
FROM Clientes c
INNER JOIN UbicacionCliente uc ON c.id = uc.cliente_id
UNION ALL
SELECT 
    'Proveedor' as tipo,
    p.nombre,
    CASE 
        WHEN p.direccion LIKE '%Calle 10%' THEN 'Bogotá'
        WHEN p.direccion LIKE '%Cra 8%' THEN 'Medellín'
        ELSE 'Otra ciudad'
    END as ciudad
FROM Proveedores p
ORDER BY ciudad, tipo, nombre;

SELECT 
    tp.tipo_nombre,
    tp.descripcion,
    COUNT(dp.id) as productos_vendidos,
    SUM(dp.cantidad) as cantidad_total,
    SUM(dp.cantidad * dp.precio) as ventas_totales
FROM TiposProductos tp
INNER JOIN Productos prod ON tp.id = prod.tipo_id
INNER JOIN DetallesPedido dp ON prod.id = dp.producto_id
GROUP BY tp.id, tp.tipo_nombre, tp.descripcion
ORDER BY ventas_totales DESC;

SELECT DISTINCT
    e.nombre as empleado_nombre,
    e.puesto,
    prov.nombre as proveedor_nombre,
    prod.nombre as producto_nombre,
    p.fecha as fecha_pedido,
    dp.cantidad
FROM Empleados e
INNER JOIN Pedidos p ON e.id = p.empleado_id
INNER JOIN DetallesPedido dp ON p.id = dp.pedido_id
INNER JOIN Productos prod ON dp.producto_id = prod.id
INNER JOIN Proveedores prov ON prod.proveedor_id = prov.id
WHERE prov.nombre = 'CuidadoElectricidad'
ORDER BY p.fecha DESC;

SELECT 
    prov.id as proveedor_id,
    prov.nombre as proveedor_nombre,
    prov.contacto,
    COUNT(DISTINCT prod.id) as productos_ofrecidos,
    COUNT(dp.id) as total_ventas,
    SUM(dp.cantidad) as unidades_vendidas,
    SUM(dp.cantidad * dp.precio) as ingresos_totales
FROM Proveedores prov
INNER JOIN Productos prod ON prov.id = prod.proveedor_id
LEFT JOIN DetallesPedido dp ON prod.id = dp.producto_id
GROUP BY prov.id, prov.nombre, prov.contacto
ORDER BY ingresos_totales DESC;