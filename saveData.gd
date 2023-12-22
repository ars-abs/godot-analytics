extends Node

func _ready():
	var data = {
		"userID": "abc",
		"data": JSON.print({
			"level":1,
			"duration": 15
		}),
		"createdAt": Time.get_datetime_string_from_system()
	}

	Analytics.save(data)
