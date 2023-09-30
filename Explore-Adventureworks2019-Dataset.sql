-- Big project for SQL

-- Query 01: Calc Quantity of items, Sales value & Order quantity by each Subcategory in L12M
#standardSQL
--SOLUTION

SELECT 
 format_datetime("%h %G",so.ModifiedDate) as period
 ,ps.Name
 ,sum(so.OrderQty) as qty_item
 ,sum(so.LineTotal) as total_sales
 ,count(so.SalesOrderID) as order_cnt
FROM `adventureworks2019.Sales.SalesOrderDetail` so
left join `adventureworks2019.Production.Product` pp  
on so.ProductID = pp.ProductID
left join `adventureworks2019.Production.ProductSubcategory` ps
on cast(pp.ProductSubcategoryID as int) = ps.ProductSubcategoryID
group by 1,2 
order by 1 desc, 2 asc

-- Query 02: Calc % YoY growth rate by SubCategory & release top 3 cat with highest grow rate. Can use metric: quantity_item. Round results to 2 decimal
#standardSQL
--SOLUTION

with sale_info as (
SELECT 
 format_timestamp("%Y",so.ModifiedDate) as yr
 ,ps.Name
 ,sum(so.OrderQty) as qty_item
FROM `adventureworks2019.Sales.SalesOrderDetail` so
left join `adventureworks2019.Production.Product` pp  
on so.ProductID = pp.ProductID
left join `adventureworks2019.Production.ProductSubcategory` ps
on cast(pp.ProductSubcategoryID as int) = ps.ProductSubcategoryID
group by 1,2
order by 1 desc, 2 asc
)
, sale_diff as (
select 
 *
 ,lead(qty_item) over(partition by name order by yr desc) as prv_qty
 ,round(qty_item / (lead(qty_item) over(partition by name order by yr desc)) -1,2) as qty_diff
from sale_info
order by 5 
)
select 
 name
 ,qty_item
 ,prv_qty
 ,qty_diff
from sale_diff
where qty_diff > 0
order by 4 desc
limit 3
  
-- Query 03: Ranking Top 3 TeritoryID with biggest Order quantity of every year. If there's TerritoryID with same quantity in a year, do not skip the rank number
#standardSQL
--SOLUTION

with sale_info as (
SELECT 
 format_timestamp("%Y",a.ModifiedDate) as yr
 ,b.TerritoryID
 ,sum(a.OrderQty) as order_cnt
FROM `adventureworks2019.Sales.SalesOrderDetail` a
left join `adventureworks2019.Sales.SalesOrderHeader` b  
on a.SalesOrderID = b.SalesOrderID
group by 1,2
)
, sale_rank as(
select
 *
 ,dense_rank() over(partition by yr order by order_cnt desc) as rk
from sale_info
)
select *
from sale_rank 
where rk <= 3
  
-- Query 04: Calc Total Discount Cost belongs to Seasonal Discount for each SubCategory
#standardSQL
--SOLUTION

with cte as (
SELECT 
 format_datetime("%Y",a.ModifiedDate) as period
 ,c.Name
 ,sum(a.UnitPrice) * d.DiscountPct * a.OrderQty as discount_cost
FROM `adventureworks2019.Sales.SalesOrderDetail` a
left join `adventureworks2019.Production.Product` b  
on a.ProductID = b.ProductID
left join `adventureworks2019.Production.ProductSubcategory` c
on cast(b.ProductSubcategoryID as int) = c.ProductSubcategoryID
left join `adventureworks2019.Sales.SpecialOffer` d
on a.SpecialOfferID = d.SpecialOfferID
where d.Type = 'Seasonal Discount'
group by 1,2, d.DiscountPct, a.OrderQty, a.UnitPrice
order by 1 desc
)
select 
 period
 ,name
 ,sum(discount_cost) as total_discount_cost
from cte
group by 1,2
  
-- Query 05: Retention rate of Customer in 2014 with status of Successfully Shipped (Cohort Analysis)
#standardSQL
--SOLUTION

with sale_info as (
select 
 CustomerID
 ,EXTRACT(month from ModifiedDate) as mth_order
 ,extract(year from ModifiedDate) as yr
from `adventureworks2019.Sales.SalesOrderHeader`
where extract(year from ModifiedDate) = 2014
and status = 5
group by 1,2,3
)
, row_num as (
select
 *
 ,row_number() over(partition by CustomerID order by mth_order asc) as rn
from sale_info
)
,first_order as (
select
 mth_order as mth_join
 ,yr
 ,CustomerID
from row_num
where rn = 1
)
select 
 mth_join
 ,concat('M-',(mth_order - mth_join)) as mth_diff
 ,count(a.CustomerID)
from sale_info a
left join first_order b
on a.CustomerID = b.CustomerID
group by 1, 2
order by 1 asc, 2 asc
  
-- Query 06: Trend of Stock level & MoM diff % by all product in 2011. If %gr rate is null then 0. Round to 1 decimal
#standardSQL
--SOLUTION

with stock_info as (
select 
 Name
 ,extract(month from b.ModifiedDate) as mth
 ,extract(year from b.ModifiedDate) as yr
 ,sum(StockedQty) as stock_qty
from `adventureworks2019.Production.Product` a
left join `adventureworks2019.Production.WorkOrder` b 
on a.ProductID = b.ProductID
where FORMAT_TIMESTAMP("%Y", b.ModifiedDate) = '2011' 
group by 1,2,3
)
select 
 *
 ,lead(stock_qty) over(partition by Name order by mth desc) as stock_prv
 ,coalesce(round(((stock_qty/(lead(stock_qty) over(partition by Name order by mth desc))-1)*100.0),1),0) as diff
from stock_info
order by Name asc
  
-- Query 07: Calc MoM Ratio of Stock / Sales in 2011 by product name
#standardSQL
--SOLUTION

with sale_info as (
select
 extract(month from b.ModifiedDate) as mth
 ,extract(year from b.ModifiedDate) as yr
 ,b.ProductID
 ,a.Name
 ,sum(b.OrderQty) as sales
from `adventureworks2019.Production.Product` a
left join `adventureworks2019.Sales.SalesOrderDetail` b
on a.ProductID = b.ProductID
where extract(year from b.ModifiedDate) = 2011
group by 1,2,3,4
)
,stock_info as (
select 
 extract(month from d.ModifiedDate) as mth
 ,extract(year from d.ModifiedDate) as yr
 ,d.ProductID
 ,c.Name
 ,sum(d.StockedQty) as stock
from `adventureworks2019.Production.Product` c
join `adventureworks2019.Production.WorkOrder` d
on c.ProductId = d.ProductID
where extract(year from d.ModifiedDate) = 2011
group by 1,2,3,4
)
select 
 sa.mth
 ,sa.yr
 ,sa.ProductID
 ,sa.Name
 ,sa.sales
 ,st.stock
 ,round(st.stock/sa.sales,1) as ratio
from sale_info sa
join stock_info st
on sa.ProductID = st.ProductID
order by 1 desc, 7 desc
  
-- Query 08: No of order and value at Pending status in 2014
#standardSQL
--SOLUTION

SELECT 
 extract(year from ModifiedDate) as yr
 ,Status
 ,count(distinct PurchaseOrderID) as order_cnt
 ,sum(TotalDue) as value
FROM `adventureworks2019.Purchasing.PurchaseOrderHeader` 
where extract(year from ModifiedDate) = 2014
and status = 1
group by 1,2
