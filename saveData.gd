extends Node

func _ready():
	var data = {
		"userID": "abc",
		"data": JSON.print({
			"level":1,
			"duration": 15
		}),
	}

	Analytics.save(data)
