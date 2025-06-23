# 🏗️ Estructura de la Base de Datos

La base de datos contiene las siguientes entidades

- `Clientes` y `UbicacionCliente`
- `Empleados`, `Puestos`, `DatosEmpleados`
- `Proveedores` y `ContactoProveedores`
- `Productos` y `TiposProductos`
- `Pedidos` y `DetallesPedido`
- `HistorialPedidos`, `EmpleadoProveedor`, `TelefonosCliente`
- `Ubicaciones`, `ClienteUbicacion`


## 🧠 Consulta Final del Punto 4

Se ejecuta la siguiente consulta para obtener un resumen por proveedor:

```sql
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
```

**Explicación:**

- Ambos proveedores ofrecen **2 productos**.
- `LapizQueRaya` vendió 2 lapiceros y 1 resma de papel → **3 unidades vendidas**.
- `CuidadoElectricidad` vendió 1 mouse y 1 laptop → **2 unidades vendidas**.
- Los ingresos son calculados como `(precio * cantidad)` por cada línea de pedido.


## 📁 Contenido del Repositorio

- `Talle_Mysql.sql`: Script completo de creación, inserción y consultas.
- `README.md`: Este archivo, con la explicación y verificación de resultados.


## 📚 Temas Aplicados

- Normalización hasta 3FN
- Relaciones uno a muchos y muchos a muchos
- Joins (INNER, LEFT, RIGHT)
- Agregaciones: `SUM`, `COUNT`, `GROUP BY`
- Consultas multitabla y subconsultas
- Uso de `DISTINCT` y funciones de agrupación

