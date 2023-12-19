extends Node

func _ready():
	var data = {
		'title': 'foo',
		'body': 'bar',
		'userId': 1,
	}
	Analytics.save(data)

