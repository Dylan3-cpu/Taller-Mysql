# 🏗️ Database Structure

The database contains the following entities

- `Clients` and `ClientLocation`
- `Employees`, `Positions`, `EmployeeData`
- `Suppliers` and `SupplierContacts`
- `Products` and `ProductTypes`
- `Orders` and `OrderDetails`
- `OrderHistory`, `EmployeeSupplier`, `ClientPhones`
- `Locations`, `ClientAddress`


## 🧠 Final Query for Point 4

The following query is executed to get a summary per supplier:

```sql
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
```

**Explanation:**

- Both suppliers offer **2 products**.
- `PencilThatWrites` sold 2 pens and 1 paper ream → **3 units sold**.
- `CarefulElectricity` sold 1 mouse and 1 laptop → **2 units sold**.
- Revenue is calculated as `(price * quantity)` for each order line.


## 📁 Repository Content

- `Taller_Mysql.sql`: Complete script for creation, insertion, and queries.
- `README.md`: This file, with explanation and result verification.


## 📚 Applied Topics

- Normalization up to 3NF
- One-to-many and many-to-many relationships
- Joins (INNER, LEFT, RIGHT)
- Aggregations: `SUM`, `COUNT`, `GROUP BY`
- Multi-table queries and subqueries
- Use of `DISTINCT` and grouping functions

