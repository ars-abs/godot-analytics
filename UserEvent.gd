extends Node
class_name UserEvent

var db: SQLiteWrapper
var table_name

func _init():
	db = SQLiteWrapper.new()
	table_name = "events"
	db.set_verbosity_level(0)
	db.path = "res://data/db.sqlite"
	db.open_db()
	createDB()
	

func create(data):
	return db.insert_row(table_name, data)

func getAll():
	return db.select_rows(table_name, '', ['id','userID', 'data', 'sync', 'createdAt'])

func update(id,data):
	var condition = "id = "+ str(id)
	return db.update_rows(table_name, condition,data)
	
func createDB():
	var schema = {
		"id": { "data_type":"int", "primary_key": true, "auto_increment":true },
		"userID": {"data_type":"text"},
		"data": {"data_type":"blob"},
		"createdAt": {"data_type":"date"},
		"sync": {"data_type":"date"}
	}
	return db.create_table(table_name, schema)
