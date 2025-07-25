create database zepto;
use zepto;
drop table if exists zepto;
rename table zepto_v2 to  zepto;
select * from zepto;
select count(*) from zepto;
select name,mrp from zepto 
where name is null or mrp is null;
-- alter
alter table zepto rename column ï»¿Category to category;
alter table zepto rename column outOfStock to outofstock;
select  distinct (category) from zepto ;

-- avilable and outofstock of product
select outofstock, count(outofstock) as count from zepto
group by outofstock;
select category ,count(category) from zepto
group by category;

-- no of repeating product 
select name , count(name) from zepto
group by name;

-- product with 0 price
select * from zepto 
where mrp=0 or discountedSellingPrice=0;
delete from zepto where mrp = 0;

-- convert price of paisa to rupees
SET SQL_SAFE_UPDATES = 0;
update zepto
set mrp = mrp/100.0 ,
discountedSellingPrice = discountedSellingPrice/100.0;

select * from zepto;
-- top 10 product based on discountprice
select distinct name ,mrp,discountPercent from zepto order by discountPercent desc limit 10;

-- product with mrp but outof stock
select name , mrp from zepto
where mrp>200 and outofstock= "true"
order by mrp desc limit 5;

-- estimate revenue for each category
select category ,
sum(discountedSellingPrice*quantity) as total_revenue from zepto group by category 
order by category;

-- name with mrp greater 500 and dp less than 10
select distinct name,mrp,discountPercent from zepto 
where mrp>500 and discountPercent<10 
order by mrp desc,discountPercent desc;

-- top 5  product based on avd dp
select distinct category,avg(discountPercent)  from zepto group by category order  by avg(discountPercent)  desc limit 5;

-- total inventory weight per category
select category , sum(weightInGms*availableQuantity)as inventory_weight from zepto
group by category 
order by inventory_weight ;

-- group category into low,medium,bulk
select category from zepto group by category;