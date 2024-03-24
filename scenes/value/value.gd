extends PanelContainer
class_name Value

@onready var edit_menu_scene = preload("res://scenes/value_edit_menu/value_edit_menu.tscn")

@onready var draggable = $Draggable
@onready var icon = $TextureRect

var draggable_type = "value"
var type
var edit_menu

func _ready():
	draggable.parent = self
	draggable.drop_type = "value"
	Global.values.append(draggable)
	
	edit_menu = edit_menu_scene.instantiate()
	edit_menu.parent = self
	Global.main.add_child(edit_menu)
	
	icon.texture = load("res://textures/items/" + Global.value_items[type]["item"] + ".png")

func _on_draggable_gui_input(event):
	if not(event is InputEventMouseButton): return
	if !event.is_pressed(): return
	if event.get_button_index() == 2:
		if edit_menu.is_visible():
			edit_menu.hide()
		else:
			edit_menu.show()
