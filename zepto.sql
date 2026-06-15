
Create table zepto (
SKU_ID SERIAL PRIMARY KEY ,
Category VARCHAR(50),
name VARCHAR (100) NOT NULL,
mrp NUMERIC (8,2),
discountPercent NUMERIC (5,2),
availableQuantity  INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INT,
outOfStock boolean,
quantity int
)



update zepto
set discountedSellingPrice = discountedSellingPrice/100 


---Beginner Level----
--1. count the number of rows present in table /  Total number of products
SELECT COUNT(*) FROM zepto 

--2 check the null data present in the table
SELECT * FROM zepto 
WHERE name IS NULL 
OR category IS NULL 
OR mrp IS NULL 
OR discountpercent IS NULL 
OR discountedsellingprice IS NULL 
OR weightingms IS NULL 
OR outofstock IS NULL 
OR quantity IS NULL;


--3. Count distinct categories in table?
select distinct(category), count(category) from zepto
group by category

--4. Find all out-of-stock products
select name, category, outOfStock, mrp from zepto
where outOfStock = 'stock_out'

--5. Find products with MRP greater than ₹500
select name, category, mrp from zepto
where mrp>500

--6. Top 10 most expensive products
select distinct(name), category,mrp, sum(availableQuantity )from zepto
group by name, category,mrp
order by mrp desc
limit 10

---Intermediate Level---
--7. Average MRP by category
select avg(mrp) as average_mrp from zepto

--8. Average discount percentage by category
select avg(discountPercent) as average_discountPercent from zepto

--9.  Products with discount greater than 40%
select distinct(name), category , discountpercent from zepto
where discountpercent > 40
order by discountpercent desc


--10. Difference between MRP and Selling Price
select name, category, mrp, discountedSellingPrice, (mrp-discountedSellingPrice) as profit_lose from zepto

--11. Which categories have the largest number of SKUs?
select category, count(SKU_ID) from zepto
group by category
order by count(SKU_ID)

--12. Premium products with low discounts
--MRP > ₹1000, Discount < 10%
select name, mrp, discountpercent from zepto
where mrp>1000 and discountpercent<10
order by mrp desc


-- Advanced Level


--13. Category-wise revenue opportunity
select category, (discountedSellingPrice *quantity) as revenue from zepto
group by category,(discountedSellingPrice *quantity) 
order by (discountedSellingPrice *quantity)  desc


--14. Price segmentation
--Create groups:
--Budget (< ₹200)
--Mid-range (₹200–₹500)
--Premium (> ₹500)
select name, category, mrp, discountedSellingPrice ,
       case 
          when discountedSellingPrice <200 then 'budget'
          when discountedSellingPrice between 200 and 500 then 'mid_range'
          else 'premium' 
          end as segmentation
		  from zepto



--15. Discount segmentation
--Create groups:
(Low Discount
Medium Discount
High Discount)

select name, category, mrp, discountPercent, 
case 
when discountPercent> 10 then 'low_discount'
when discountPercent between 10 and 30 then 'medium_discount'
else 'high_discount'
end as dis_segment
from zepto
order by discountPercent 


--16. Identify pricing anomalies( there products where Selling Price exceeds MRP?)
select name, category, mrp, discountedSellingPrice from zepto
where (discountedSellingPrice - mrp) >0


--17. Find duplicate product names
select name, count(name) from zepto
group by name
having count(name) > 1
order by count(name) desc

--18. Top categories contributing to inventory
select category, sum(discountedSellingPrice) as total_SP FROM ZEPTO
GROUP BY CATEGORY
ORDER BY sum(discountedSellingPrice) DESC 

--19. Rank products by discount within each category
SELECT CATEGORY, SUM(discountPercent)AS DISCOUNT, RANK () OVER (order by SUM(discountPercent) desc)as ranking FROM ZEPTO
group by caterogy













































