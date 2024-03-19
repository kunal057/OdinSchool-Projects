select * from customers;
select * from orderdetails;

### Que 1 : How Many unique cities does the data have ?
select distinct(city)
from customers;

### Que 2 : How many unique product lines does the data have ? 
select distinct(productline)
from productlines;

### Que 3 : How many unique product vendors does the data have ? 
select distinct(productvendor)
from products;

### Que 4 : How many products are there in each  product lines 
select count(p.productname) ,pl.productline 
from products p 
inner join productlines pl on p.productline=pl.productline 
group by pl.productline;

### Que 5 : Count of ordered products from different country 
select (c.country),count(od.quantityordered) as totalorders
from customers c
inner join orders o on o.customernumber=c.customernumber
inner join orderdetails od on od.ordernumber=o.ordernumber
group by c.country;

### Que 6 : Finding top 10 customers in terms of total sales
select c.customerNumber ,c.customerName ,
sum(od.quantityOrdered * od.priceEach) as Totalpurchase from customers as c
inner join orders as o on c.customerNumber=o.customerNumber
inner join orderdetails as od  on od.orderNumber=o.orderNumber
group by c.customerNumber,c.customerName
order by Totalpurchase desc
limit 10;

### Que 7 : Finding top 10 sales representative in terms of total sales
select c.salesRepEmployeeNumber ,  e.firstname , e.lastname,e.jobTitle,sum(od.quantityOrdered*od.priceEach) as totalsales
from customers as c
inner join employees as e on c.salesRepEmployeeNumber=e.employeeNumber
inner join orders as o on c.customerNumber=o.customerNumber
inner join orderdetails as od on o.orderNumber=o.orderNumber
group by c.salesRepEmployeeNumber
order by totalsales desc
limit 10;

### Que 8 : Find Top sold product along with year
select p.productCode,p.productName,year(o.orderdate) as orderyear ,sum(od.priceEach*od.quantityOrdered) as totalsales
from orders as o
inner join orderdetails as od on o.orderNumber=od.orderNumber
inner join products as p on od.productCode=p.productCode
group by p.productCode , p.productName ,orderyear
order by totalsales desc;

### Que 9 : Find which vendors product sold more than 500000
select t1.productvendor,t1.totalsales as vendortotalsales from (
select p.productVendor,sum(od.priceEach*od.quantityOrdered) as totalsales
from orders as o
inner join orderdetails od on o.orderNumber = od.orderNumber
inner join products p on od.productCode=p.productCode
group by productvendor) as t1
group by t1.productvendor 
having sum(totalsales)>500000
order by vendortotalsales desc;

### Que 10 : Finding how many orders placed year wise 
select year(o.orderdate) as orderedyear ,
count(o.ordernumber) as totalnumberoforders
from orders as o
group by orderedyear;

### Que 11 : Finding top 5 productline which has highest number of qunatity sold along with sales amount 
select p.productline , count(od.ordernumber) as quantityOrdered , sum(od.priceEach*od.quantityOrdered) as totalsales
from orderdetails od
inner join products p on od.productCode=p.productCode
group by p.productline
order by quantityOrdered desc
limit 5;

 