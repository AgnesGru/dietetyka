--1)	podaj 3 top produkty w ka¿dej z grup artyku³ow (in terms of revenue)? 
select distinct [Article Group] from dbo.Items$;
--Coffee
--Accessories
--Machine
--Kaffee
--
WITH TOPTHREE AS (
    SELECT SKU, round(sum([Price (in €)]),2) as sum_, [Article Group], 
	ROW_NUMBER() over (
        PARTITION BY [Article Group]
        order by sum([Price (in €)]) desc) AS RowNo 
    FROM dbo.Items$
	group by [Article Group], SKU
)
SELECT * FROM TOPTHREE WHERE RowNo <= 3

--liquid-descaler-1
--latte-macchiato-glass
--thermobecher-metallic-grau
--davinci-madagascar-vanilla-macchiato
--advantage-pack-cappuccino
--advantage-pack-grande
--vorratsbox-cafe-with-milk
--indigo-s-plus-amsterdam-automatik-schwarz
--Ristretta Milano Black
--Ristretta Milano White
------------------------------------------
select top 3 sku, [Article Group], round(sum([Price (in €)]), 2) sum_ 
from dbo.Items$ 
where [Article Group] = 'Coffee'
group by [Article Group], sku
order by sum_  desc;

--- tylko jeden produkt
select distinct sku from dbo.Items$
where [Article Group] = 'Kaffee';
--
--ile jest wszystkich zamówieñ?
select count(*) from dbo.Orders$;
--8172

--jaka czêœæ zamówieñ zawiera³a te produkty?
select count(o.[Order ID]) ile
from dbo.Orders$ o
join dbo.Items$ i
	on o.[Order ID]=i.[Order ID]
where i.[sku] = ('vorratsbox-cafe-with-milk');


--2) On average, how many cups of coffee are bought per order?
select * from dbo.Items$
where SKU like '%cup%';
--zrób widok
--CREATE VIEW dbo.Cups 
--as 
--select [Order ID], sum([Quantity ordered]) suma from dbo.Items$
--where SKU like '%cup%'
--group by [Order ID];

select * from dbo.Cups;

--3)	Who are the top 10 most valuable customers (in terms of revenue)? 
select top 10 c.[Customer ID], round(sum([Invoice Value (in €)]), 0) as sum_of_orders
from dbo.Customers$ c
join dbo.Orders$ o
	on c.[Customer ID]=o.[Customer ID]
group by c.[Customer ID]
order by sum_of_orders desc;

--4)	What is the average revenue per customer by cohort? 
--Please visualize with a chart of your choice. 
--Which cohort has on average the most valuable, and which the least valuable customers? 
--(Cohort is defined as ‘year’ e.g. if a customer has registered in January 2021, he belongs in the 2021 cohort.)


--5) Which products and how many are sold with ‘Ristretta Milano Black’ machine?
select sku , count(sku) as number
from dbo.Items$
where [Order ID] in (
select [Order ID] from dbo.Items$
where sku = 'Ristretta Milano Black')
and sku != 'Ristretta Milano Black'
group by SKU
order by number desc; 

--Bonus
--6)	What is the average price per capsule, considering quantity ordered?
