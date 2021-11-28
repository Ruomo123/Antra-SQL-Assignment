-- 24.	Looks like that it is our missed purchase orders. Migrate these data into Stock Item, 
-- Purchase Order and Purchase Order Lines tables. Of course, save the script.

declare @json nvarchar(max) = N'{
   "PurchaseOrders":[
      {
         "StockItemName":"Panzer Video Game",
         "Supplier":"7",
         "UnitPackageId":"1",
         "OuterPackageId":[
            6,
            7
         ],
         "Brand":"EA Sports",
         "LeadTimeDays":"5",
         "QuantityPerOuter":"1",
         "TaxRate":"6",
         "UnitPrice":"59.99",
         "RecommendedRetailPrice":"69.99",
         "TypicalWeightPerUnit":"0.5",
         "CountryOfManufacture":"Canada",
         "Range":"Adult",
         "OrderDate":"2018-01-01",
         "DeliveryMethod":"Post",
		 "DeliveryMethodID" :"1",
         "ExpectedDeliveryDate":"2018-02-02",
         "SupplierReference":"WWI2308"
      },
      {
         "StockItemName":"Panzer Video Game",
         "Supplier":"5",
         "UnitPackageId":"1",
         "OuterPackageId":"7",
         "Brand":"EA Sports",
         "LeadTimeDays":"5",
         "QuantityPerOuter":"1",
         "TaxRate":"6",
         "UnitPrice":"59.99",
         "RecommendedRetailPrice":"69.99",
         "TypicalWeightPerUnit":"0.5",
         "CountryOfManufacture":"Canada",
         "Range":"Adult",
         "OrderDate":"2018-01-025",  
         "DeliveryMethod":"Post",  
		 "DeliveryMethodID" :"1",
         "ExpectedDeliveryDate":"2018-02-02",
         "SupplierReference":"269622390"
      }
   ]
}';
-- delivery method of "post" corresponds to delivery method id of 1, therefore I added the DeliveryMethodID column into the json data
-- insert into StockItems table
insert into [Warehouse].[StockItems]
select *
from openjson(@json)
with (
	StockItemName nvarchar(100) '$.StockItemName',
	SupplierID int '$.Supplier',
	UnitPackageId int '$.UnitPackageId',
	OuterPackageId int '$.OuterPackageId',
	Brand nvarchar(50) '$.Brand',
	LeadTimeDays int '$.LeadTimeDays',
	QuantityPerOuter int '$.QuantityPerOuter ',
    TaxRate decimal(18,3) '$.TaxRate',
    UnitPrice decimal(18,2) '$.UnitPrice',
    RecommendedRetailPrice decimal(18,2) '$.RecommendedRetailPrice',
    TypicalWeightPerUnit decimal(18,3) '$.TypicalWeightPerUnit'
)
-- insert into PurchaseOrders table
insert into [Purchasing].[PurchaseOrders]
select *
from openjson(@json)
with (
	SupplierID int '$.Supplier',
    OrderDate date '$.OrderDate',
    ExpectedDeliveryDate date '$.ExpectedDeliveryDate',
	DeliveryMethodID int '$.DeliveryMethodID',
    SupplierReference nvarchar(20) '$.SupplierReference'
)
-- insert into PurchaseOrderLines table
