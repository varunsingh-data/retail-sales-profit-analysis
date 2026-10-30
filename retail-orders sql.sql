USE ecommerce_analysis;
select * from superstore;

SELECT COUNT(*) AS total_rows
FROM superstore;


select sum(sales_kes) as total_sales from superstore;

select sum(profit_kes) as total_profit from superstore;

select sum(quantity) as total_quantity from superstore;

select category,sum(sales_kes) as total_sales from superstore
group by category
order by total_sales desc;

select category,sum(profit_kes) as total_profit from superstore
group by category 
order by total_profit desc;

select region,sum(sales_kes) as total_sales from superstore 
group by region 
order by total_sales; 

select product_name,sum(sales_kes) as total_sales from superstore
group by product_name 
order by total_sales desc
limit 10;

select product_name ,sum(profit_kes) as total_profit from superstore
group by product_name
order by total_profit desc
limit 10;

select product_name ,sum(profit_kes) as total_profit from superstore
group by product_name 
having sum(profit_kes)<0
order by total_profit
limit 10;

select segment,sum(sales_kes) as total_sales,sum(profit_kes) as total_profit from superstore
group by segment
order by total_sales desc;

select date_format(order_date,'%y-%m') as sales_month,
sum(sales_kes) as total_sales from superstore
group by date_format(order_date,'%y-%m')
order by total_sales asc;


SELECT
	DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
	SUM(sales_kes) AS total_sales
FROM superstore
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

SELECT order_date
FROM superstore
LIMIT 10;

select date_format(order_date,'%y-%m') as sales_month,
sum(sales_kes) as total_sales from superstore
group by sales_month
order by sales_month asc;

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    SUM(sales_kes) AS total_sales
FROM superstore
GROUP BY sales_month
ORDER BY sales_month asc;

SELECT date_format(order_date,'%y-%m') AS sales_month,
sum(profit_kes) AS total_profit from superstore
group by sales_month
order by sales_month ASC;

select discount,
avg(profit_kes) as avg_profit,
sum(sales_kes) as total_sales
from superstore
group by discount
order by discount;

select ship_mode,
sum(profit_kes) as total_profit,
avg(profit_kes) as avg_profit,
sum(sales_kes) as total_sales from superstore 
group by ship_mode
order by total_profit desc;

select customer_id,
customer_name,
sum(sales_kes) as total_sales,
sum(profit_kes) as total_profit from superstore
group by customer_id,customer_name
order by total_profit asc
limit 10;

SELECT
    category,
    SUM(sales_kes) AS total_sales,
    SUM(profit_kes) AS total_profit,
    ROUND(
        SUM(profit_kes) / NULLIF(SUM(sales_kes), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
GROUP BY category
ORDER BY profit_margin_pct DESC;

select year(order_date) as year,
sum(sales_kes) as total_sales,
sum(profit_kes) as total_profit from superstore
group by year
order by year;

select year(order_date) as year,
round(sum(profit_kes) / nullif(sum(sales_kes),0)*100,2) as margin_pct from superstore
group by year
order by year;

select region,sum(profit_kes) as total_profit, sum(sales_kes) as total_sales,
round(sum(profit_kes)/nullif(sum(sales_kes),0)*100,2) as margin_pr from superstore 
group by region
order by margin_pr desc;

SELECT
    sub_category,
    SUM(sales_kes) AS total_sales,
    SUM(profit_kes) AS total_profit
FROM superstore
GROUP BY sub_category
ORDER BY total_profit ASC;

SELECT
    sub_category,
    discount,
    SUM(sales_kes) AS total_sales,
    SUM(profit_kes) AS total_profit
FROM superstore
WHERE sub_category IN ('Tables', 'Bookcases')
GROUP BY sub_category, discount
ORDER BY sub_category, discount;


SELECT
    sub_category,
    discount,
    ROUND(
        SUM(profit_kes) / NULLIF(SUM(sales_kes), 0) * 100,
        2
    ) AS profit_margin_pct
FROM superstore
WHERE sub_category IN ('Tables', 'Bookcases')
GROUP BY sub_category, discount
ORDER BY sub_category, discount;

SELECT
    ship_mode,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days;

SELECT
    ship_mode,
    COUNT(*) AS total_orders,
    SUM(
        CASE
            WHEN DATEDIFF(ship_date, order_date) > 5 THEN 1
            ELSE 0
        END
    ) AS shipped_after_5_days
FROM superstore
GROUP BY ship_mode
ORDER BY shipped_after_5_days DESC;

SELECT
    ship_mode,
    ROUND(
        SUM(CASE
            WHEN DATEDIFF(ship_date, order_date) > 5 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS delayed_percentage
FROM superstore
GROUP BY ship_mode
ORDER BY delayed_percentage DESC;



SELECT
    ship_mode,
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_shipping_days,
    MAX(DATEDIFF(ship_date, order_date)) AS max_shipping_days
FROM superstore
GROUP BY ship_mode
ORDER BY avg_shipping_days DESC;



SELECT
    CASE
        WHEN DATEDIFF(ship_date, order_date) > 5 THEN 'Over 5 Days'
        ELSE '5 Days or Less'
    END AS shipping_time,
    COUNT(*) AS total_rows,
    ROUND(SUM(profit_kes), 2) AS total_profit,
    ROUND(AVG(profit_kes), 2) AS avg_profit
FROM superstore
GROUP BY shipping_time;


SELECT
    region,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN profit_kes < 0 THEN 1 ELSE 0 END) AS loss_rows,
    ROUND(SUM(profit_kes), 2) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_profit ASC;



SELECT
    region,
    COUNT(*) AS total_rows,
    SUM(CASE WHEN profit_kes < 0 THEN 1 ELSE 0 END) AS loss_rows,
    ROUND(
        SUM(CASE WHEN profit_kes < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS loss_percentage
FROM superstore
GROUP BY region
ORDER BY loss_percentage DESC;


SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(SUM(sales_kes), 2) AS total_sales,
    ROUND(SUM(profit_kes), 2) AS total_profit,
    ROUND(
        SUM(profit_kes) * 100.0 / SUM(sales_kes),
        2
    ) AS profit_margin
FROM superstore;