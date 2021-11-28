-- 22.	Create a new table called ods.StockItem. 
-- It has following columns: [StockItemID], [StockItemName] ,[SupplierID] ,[ColorID] ,[UnitPackageID] ,[OuterPackageID] ,
-- [Brand] ,[Size] ,[LeadTimeDays] ,[QuantityPerOuter] ,[IsChillerStock] ,[Barcode] ,[TaxRate]  ,[UnitPrice],[RecommendedRetailPrice] ,
-- [TypicalWeightPerUnit] ,[MarketingComments]  ,[InternalComments], [CountryOfManufacture], [Range], [Shelflife]. 
-- Migrate all the data in the original stock item table.
drop table if exists ods.StockItem
select	StockItemID, 
		StockItemName,
		SupplierID ,
		ColorID,
		UnitPackageID,
		OuterPackageID,
		Brand,
		Size,
		LeadTimeDays,
		QuantityPerOuter,
		IsChillerStock,
		Barcode,
		TaxRate,
		UnitPrice,
		RecommendedRetailPrice,
		TypicalWeightPerUnit,
		MarketingComments,
		InternalComments, 
JSON_VALUE(CustomFields, '$.CountryOfManufacture') CountryOFManufacutre, 
JSON_VALUE(CustomFields,'$.Range') Range, 
JSON_VALUE(CustomFields,'$.ShelfLife') ShelfLife
into ods.StockItem
from Warehouse.StockItems;
 
select * from ods.StockItem;