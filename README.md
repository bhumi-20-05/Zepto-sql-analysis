# Zepto-sql-analysis
* Introduction
* Project goals
* Data cleaning
* Analysis queries
* Insights
* Tools
* File structure
* Next steps

# Zepto SQL Inventory & Sales Analysis

This project focuses on performing SQL-based data analysis on Zepto's product inventory and pricing data. The aim is to clean, explore, and derive actionable business insights that can assist in decision-making regarding pricing, stock levels, and revenue optimization.

## 📌 Project Objectives

- Clean raw product data and fix formatting issues
- Identify out-of-stock and duplicate products
- Convert pricing from paisa to rupees
- Detect zero or missing pricing entries
- Estimate revenue by category
- Highlight top products based on discounts and price
- Evaluate inventory distribution across product categories

## 🧼 Data Cleaning Steps

1. Dropped `zepto` table if it existed and renamed `zepto_v2` to `zepto`
2. Renamed columns for consistency:
   - `ï»¿Category` → `category`
   - `outOfStock` → `outofstock`
3. Removed records where `mrp = 0`
4. Converted `mrp` and `discountedSellingPrice` from **paisa to rupees**
5. Checked and flagged rows with null `name` or `mrp` values

---

## Key SQL Analyses

### 🔹 Null & Duplicate Checks
SELECT name, mrp FROM zepto WHERE name IS NULL OR mrp IS NULL;
SELECT name, COUNT(*) FROM zepto GROUP BY name HAVING COUNT(*) > 1;

### 🔹 Product Availability
SELECT outofstock, COUNT(*) FROM zepto GROUP BY outofstock;

### 🔹 Category Distribution
SELECT category, COUNT(*) FROM zepto GROUP BY category;

### 🔹 Zero-Priced Products
SELECT * FROM zepto WHERE mrp = 0 OR discountedSellingPrice = 0;
DELETE FROM zepto WHERE mrp = 0;

### 🔹 Price Conversion (Paisa to Rupees)
SET SQL_SAFE_UPDATES = 0;
UPDATE zepto SET mrp = mrp / 100.0, discountedSellingPrice = discountedSellingPrice / 100.0;

### 🔹 Top 10 Products by Discount
SELECT DISTINCT name, mrp, discountPercent 
FROM zepto 
ORDER BY discountPercent DESC 
LIMIT 10;

### 🔹 High-MRP, Out-of-Stock Products
SELECT name, mrp 
FROM zepto 
WHERE mrp > 200 AND outofstock = 'true' 
ORDER BY mrp DESC 
LIMIT 5;

### 🔹 Revenue Estimation by Category
SELECT category, SUM(discountedSellingPrice * quantity) AS total_revenue 
FROM zepto 
GROUP BY category 
ORDER BY total_revenue DESC;

### 🔹 High MRP + Low Discount Products
SELECT DISTINCT name, mrp, discountPercent 
FROM zepto 
WHERE mrp > 500 AND discountPercent < 10 
ORDER BY mrp DESC, discountPercent DESC;

### 🔹 Top 5 Categories by Avg. Discount
SELECT category, AVG(discountPercent) 
FROM zepto 
GROUP BY category 
ORDER BY AVG(discountPercent) DESC 
LIMIT 5;

### 🔹 Total Inventory Weight by Category
SELECT category, SUM(weightInGms * availableQuantity) AS inventory_weight 
FROM zepto 
GROUP BY category 
ORDER BY inventory_weight DESC;

## 📊 Insights Derived

* Several products were listed with missing or zero pricing—highlighting the need for validation during listing.
* Certain categories carried bulk inventory weight but contributed less revenue.
* Some high-MRP products were out of stock—indicating potential missed opportunities.
* Tuesdays and Sundays showed higher out-of-stock events (linked to dashboard insights).
* Categories like "Beverages" and "Snacks" often had the deepest discounts.

## 🛠️ Tools Used

* **MySQL** for querying and data analysis
* **MySQL Workbench** as the SQL execution environment
* **Power BI** for optional dashboard visualization (not part of this repo)






