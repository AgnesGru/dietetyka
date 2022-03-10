-- [Customer Id], [Item Id], [Order Id] zrób not null, int i primary key

Alter table dbo.Customers$
 alter column [Customer ID] int not null;

 Alter table dbo.Customers$
	Add Constraint PK_CustomerID
	Primary key ([Customer ID]);

Alter table dbo.Items$
 alter column [Item ID] int not null;

 Alter table dbo.Items$
	Add Constraint PK_ItemID
	Primary key ([Item ID]);

Alter table dbo.Orders$
 alter column [Order ID] int not null;

 Alter table dbo.Orders$
	Add Constraint PK_OrderID
	Primary key ([Order ID]);

-- ustaw klucze obce
Alter table dbo.Orders$
 alter column [Customer ID] int;

ALTER TABLE dbo.Orders$
ADD CONSTRAINT fk_OrderCustomer
FOREIGN KEY ([Customer ID]) 
REFERENCES dbo.Customers$([Customer ID]);

Alter table dbo.Items$
 alter column [Order ID] int;

ALTER TABLE dbo.Items$
ADD CONSTRAINT fk_ItemOrder
FOREIGN KEY ([Order ID]) 
REFERENCES dbo.Orders$([Order ID]);