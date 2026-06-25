/*==============================================================
            ATLIQ BUSINESS INSIGHTS 360 - SQL ANALYSIS
---------------------------------------------------------------
Author  : Mihir Saiya 
Objective:
Perform business analysis using SQL to support the Power BI
dashboard by answering key business questions.
==============================================================*/

USE gdb041;





/*==============================================================
Q1. Gross Sales by Fiscal Year
==============================================================*/

SELECT
    CASE
        WHEN MONTH(s.date) >= 9 THEN YEAR(s.date)+1
        ELSE YEAR(s.date)
    END AS Fiscal_Year,

    ROUND(SUM(s.sold_quantity * gp.gross_price),2) AS Gross_Sales

FROM fact_sales_monthly s

JOIN gdb056.gross_price gp
ON s.product_code = gp.product_code
AND (
        CASE
            WHEN MONTH(s.date)>=9 THEN YEAR(s.date)+1
            ELSE YEAR(s.date)
        END
    ) = gp.fiscal_year

GROUP BY Fiscal_Year
ORDER BY Fiscal_Year;





/*==============================================================
Q2. Top 10 Markets by Gross Sales
==============================================================*/

SELECT

    s.market,

    ROUND(SUM(s.sold_quantity * gp.gross_price),2) AS Gross_Sales

FROM fact_sales_monthly s

JOIN gdb056.gross_price gp

ON s.product_code = gp.product_code

AND (
        CASE
            WHEN MONTH(s.date)>=9 THEN YEAR(s.date)+1
            ELSE YEAR(s.date)
        END
    ) = gp.fiscal_year

GROUP BY s.market

ORDER BY Gross_Sales DESC

LIMIT 10;





/*==============================================================
Q3. Top 10 Customers by Gross Sales
==============================================================*/

SELECT

    customer_name,

    ROUND(SUM(sold_quantity * gp.gross_price),2) AS Gross_Sales

FROM fact_sales_monthly s

JOIN gdb056.gross_price gp

ON s.product_code = gp.product_code

AND (
        CASE
            WHEN MONTH(s.date)>=9 THEN YEAR(s.date)+1
            ELSE YEAR(s.date)
        END
    ) = gp.fiscal_year

GROUP BY customer_name

ORDER BY Gross_Sales DESC

LIMIT 10;





/*==============================================================
Q4. Top 10 Products by Sales Quantity
==============================================================*/

SELECT

    product,

    SUM(sold_quantity) AS Units_Sold

FROM fact_sales_monthly

GROUP BY product

ORDER BY Units_Sold DESC

LIMIT 10;





/*==============================================================
Q5. Monthly Sales Trend
==============================================================*/

SELECT

    MONTHNAME(date) AS Month,

    SUM(sold_quantity) AS Units_Sold

FROM fact_sales_monthly

GROUP BY MONTH(date),MONTHNAME(date)

ORDER BY MONTH(date);





/*==============================================================
Q6. Sales Performance by Segment
==============================================================*/

SELECT

    segment,

    SUM(sold_quantity) AS Units_Sold

FROM fact_sales_monthly

GROUP BY segment

ORDER BY Units_Sold DESC;





/*==============================================================
Q7. Revenue by Division
==============================================================*/

SELECT

    s.division,

    ROUND(SUM(s.sold_quantity * gp.gross_price),2) AS Gross_Sales

FROM fact_sales_monthly s

JOIN gdb056.gross_price gp

ON s.product_code = gp.product_code

AND (
        CASE
            WHEN MONTH(s.date)>=9 THEN YEAR(s.date)+1
            ELSE YEAR(s.date)
        END
    ) = gp.fiscal_year

GROUP BY s.division

ORDER BY Gross_Sales DESC;





/*==============================================================
Q8. Top 5 Products by Gross Sales
==============================================================*/

SELECT

    product,

    ROUND(SUM(sold_quantity * gp.gross_price),2) AS Gross_Sales

FROM fact_sales_monthly s

JOIN gdb056.gross_price gp

ON s.product_code = gp.product_code

AND (
        CASE
            WHEN MONTH(s.date)>=9 THEN YEAR(s.date)+1
            ELSE YEAR(s.date)
        END
    ) = gp.fiscal_year

GROUP BY product

ORDER BY Gross_Sales DESC

LIMIT 5;





/*==============================================================
Q9. Top 10 Customers by Sales Quantity
==============================================================*/

SELECT

    customer_name,

    SUM(sold_quantity) AS Units_Sold

FROM fact_sales_monthly

GROUP BY customer_name

ORDER BY Units_Sold DESC

LIMIT 10;





/*==============================================================
Q10. Executive Business Summary
==============================================================*/

SELECT

    COUNT(DISTINCT customer_code) AS Total_Customers,

    COUNT(DISTINCT product_code) AS Total_Products,

    COUNT(DISTINCT market) AS Total_Markets,

    SUM(sold_quantity) AS Total_Units_Sold

FROM fact_sales_monthly;