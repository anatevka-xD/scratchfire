extends Control
class_name ValueEditMenu

var parent

func _ready():
	hide()
	setup()

func _process(_delta):
	global_position = parent.global_position + Vector2(32, 0)

func setup():
	pass
