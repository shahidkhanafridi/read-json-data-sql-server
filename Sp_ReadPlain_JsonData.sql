CREATE PROCEDURE Sp_ReadPlain_JsonData
	@JsonData NTEXT = '[
 { "id" : 2,"name": "John"},
 { "id" : 5,"name": "John"}
]'
AS
BEGIN
	select * from OPENJSON(@jsonData)
	WITH (Id int '$.id', UserName nvarchar(max) '$.name')
END
