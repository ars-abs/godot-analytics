extends Node

var db = SQLiteWrapper.new()

func _ready():
	db.path = "database.sqlite"

	if db.open_db():
		print("Database opened successfully.")
	else:
		print("Failed to open the database.")

	var schema = {
		"id": { "data_type":"int", "primary_key": true, "auto_increment":true },
		"name": {"data_type":"text"},
		"health": {"data_type":"int"},
	}
	
	if db.create_table("monsters", schema):
		print("Table 'monsters' created successfully.")
	else:
		print("Failed to create table 'monsters'.")

	var data = {
		"name": "Dragon",
		"health": 100
	}
	if db.insert_row("monsters", data):
		print("Row inserted successfully.")
	else:
		print("Failed to insert row.")

	var selected_columns = ["id", "name", "health"]
	var query_conditions = ""
	var result = db.select_rows("monsters", query_conditions, selected_columns)
	print("Selected Rows:")
	print(result)

	var updated_row = {
		"health": 150
	}
	var update_conditions = "name = 'Dragon'"
	if db.update_rows("monsters", update_conditions, updated_row):
		print("Row updated successfully.")
	else:
		print("Failed to update row.")

	result = db.select_rows("monsters", query_conditions, selected_columns)
	print("Selected Rows After Update:")
	print(result)

	var delete_conditions = "name = 'Dragon'"
	if db.delete_rows("monsters", delete_conditions):
		print("Row deleted successfully.")
	else:
		print("Failed to delete row.")

	result = db.select_rows("monsters", query_conditions, selected_columns)
	print("Selected Rows After Delete:")
	print(result)

	db.close_db()
	print("Database closed.")
