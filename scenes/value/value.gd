extends PanelContainer

@onready var draggable = $Draggable
@onready var icon = $TextureRect

var draggable_type = "value"
var type
var edit_menu

func _ready():
	draggable.parent = self
	draggable.drop_type = "value"
	Global.values.append(draggable)
	
	icon.texture = load("res://textures/items/" + Global.value_items[type]["item"] + ".png")
	
	create_edit_menu()

func _on_draggable_gui_input(event):
	if not(event is InputEventMouseButton): return
	if !event.is_pressed(): return
	if event.get_button_index() == 2:
		if edit_menu:
			if edit_menu.is_visible():
				edit_menu.hide()
			else:
				edit_menu.show()

func create_edit_menu():
	match type:
		"STRING":
			edit_menu = load("res://scenes/value_edit_menu/string_edit_menu/string_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"STYLED TEXT":
			edit_menu = load("res://scenes/value_edit_menu/styled_text_edit_menu/styled_text_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"NUMBER":
			edit_menu = load("res://scenes/value_edit_menu/number_edit_menu/number_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"LOCATION":
			edit_menu = load("res://scenes/value_edit_menu/location_edit_menu/location_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"VECTOR":
			edit_menu = load("res://scenes/value_edit_menu/vector_edit_menu/vector_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"SOUND":
			edit_menu = load("res://scenes/value_edit_menu/sound_edit_menu/sound_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"PARTICLE":
			edit_menu = load("res://scenes/value_edit_menu/particle_edit_menu/particle_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"POTION EFFECT":
			edit_menu = load("res://scenes/value_edit_menu/potion_edit_menu/potion_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"VARIABLE":
			edit_menu = load("res://scenes/value_edit_menu/variable_edit_menu/variable_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"GAME VALUE":
			edit_menu = load("res://scenes/value_edit_menu/game_value_edit_menu/game_value_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
		"PARAMETER":
			edit_menu = load("res://scenes/value_edit_menu/parameter_edit_menu/parameter_edit_menu.tscn").instantiate()
			edit_menu.parent = self
			Global.main.add_child(edit_menu)
