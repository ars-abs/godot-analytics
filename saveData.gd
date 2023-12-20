extends Node

func _ready():
	var data = {
		"userId": "123",
		"createdAt": "2023-12-18T12:00:00",
		"level": 4,
		"duration": 10
	}
	Analytics.save(data)
	yield(Analytics.http_request, "request_completed")
	print("Backend Data:", Analytics.prettyResponse)
