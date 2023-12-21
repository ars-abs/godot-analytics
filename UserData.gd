extends Node

func _ready():
	pass

func save(data):
	print(JSON.print(data, "\t"))
