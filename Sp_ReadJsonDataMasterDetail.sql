CREATE PROCEDURE Sp_ReadJsonDataMasterDetail
	@JsonData NTEXT = '[
  {
    "CustomerID": 1,
    "Name": "John Smith",
    "Address": {
      "Street": "1 Main St",
      "City": "New York",
      "State": "NY",
      "ZipCode": "10001"
    },
    "Orders": [
      {
        "OrderID": 123,
        "OrderDate": "2023-12-14",
        "Total": 100.00
      },
      {
        "OrderID": 456,
        "OrderDate": "2023-12-10",
        "Total": 50.00
      }
    ]
  },
  {
    "CustomerID": 2,
    "Name": "Jane Doe",
    "Address": {
      "Street": "10 Elm St",
      "City": "Los Angeles",
      "State": "CA",
      "ZipCode": "90001"
    },
    "Orders": [
      {
        "OrderID": 789,
        "OrderDate": "2023-12-08",
        "Total": 200.00
      }
    ]
  }
]'
AS
BEGIN
	SELECT
	  CustomerID,
	  CustomerName,
	  Street
	  City,
	  [State],
	  ZipCode,
	  OrderID,
	  OrderDate,
	  Total
	FROM OPENJSON(@JsonData)
	WITH (CustomerID int, CustomerName nvarchar(max) '$.Name', Orders nvarchar(max) '$.Orders' as JSON, Addresses nvarchar(max) '$.Address' as JSON)
	OUTER APPLY OPENJSON(Orders) WITH (OrderID int, OrderDate datetime, Total decimal)
	OUTER APPLY OPENJSON(Addresses) WITH (Street nvarchar(max),City nvarchar(100),[State] nvarchar(100), ZipCode nvarchar(20))
END
GO
