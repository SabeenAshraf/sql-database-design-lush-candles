# 🕯️ Lush Candles SQL Project

This project represents a complete SQL-based backend for a fictional candle shop called **Lush Candles**. It demonstrates strong relational database design principles, includes realistic sample data, and showcases advanced SQL features like **triggers**, **views**, and **logging**.

---

## 📌 Key Features

- ✅ Fully normalized schema with 3NF design
- 🔗 Foreign key constraints across multiple tables
- 🧾 Custom views to generate client invoices and purchase descriptions
- 🔁 Triggers:
  - Automatically log new customer insertions
  - Dynamically update stock after a sale
- 📄 Sample data for customers, items, orders, and more

---

## 📂 Files

| File | Description |
|------|-------------|
| `lushcandles.sql` | Full SQL script (DDL, DML, views, triggers, constraints) |
| `ERD.png` *(optional)* | Entity Relationship Diagram (recommended for visualization) |

---

## 🧱 Database Schema Overview

- **Location** – Stores customer addresses
- **Customer** – Contains customer details
- **Storages** – Warehouses managing product inventory
- **Items** – Products for sale
- **Orders & Ordered_Items** – Order and purchase details
- **Deliveries** – Shipping info and status
- **Rating** – Customer feedback and ratings
- **Log** – Activity logging for trigger events

---

## 🔁 Triggers

### 📝 `customer_insert_log`
Automatically inserts a message into the `log` table whenever a new customer is added.

### 📦 `update_stock_after_order`
Adjusts `Stock_Quantity` in the `Items` table after a new order is placed and logs the change.

---

## 👁️ Views

### `customer_invoices`
Returns invoice-style data including:
- Purchase date
- Client name
- Address
- Total amount after discounts

### `customer_invoices_description`
Returns detailed invoice breakdown including:
- Item description
- Quantity
- Discount, Tax, and Total

---

## 🚀 How to Run

1. Import `lushcandles.sql` into MySQL (Workbench, phpMyAdmin, or CLI).
2. Run queries like:

```sql
-- View logs
SELECT * FROM log;

-- See invoice for a specific customer
SELECT * FROM customer_invoices WHERE Client_Name = 'Athene Bradneck';
