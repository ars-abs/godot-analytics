extends Node

func _ready():
	pass

func save(data):
	var user_event = UserEvent.new()
	user_event.update(data.id, {"syncAt": Time.get_datetime_string_from_system(), "sync": 1})
	print(JSON.print(data, "\t"))
