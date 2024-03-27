extends ValueEditMenu

@onready var value_type_button = $VBoxContainer/HBoxContainer2/ValueType

func setup():
	for type in Global.parameter_types:
		var icon = load("res://textures/items/" + Global.parameter_types[type]["item"] + ".png")
		value_type_button.add_icon_item(icon, type.capitalize())
	
	value_type_button.selected = 9
