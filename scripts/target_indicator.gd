extends HBoxContainer

var target_type_menu = Global.main.target_type_menu
var target_type_menu_button = Global.main.target_type_menu_button

var target_types

@onready var codeblock = $"../../../../.."

func _on_panel_container_gui_input(event):
	if not(event is InputEventMouseButton): return
	if !event.is_pressed(): return
	if event.get_button_index() == 2:
		#Get codeblock specific targets
		if codeblock.data["name"] == "ENTITY ACTION" or codeblock.data["name"] == "IF ENTITY":
			target_types = Global.entity_target_types
		if codeblock.data["name"] == "PLAYER ACTION" or codeblock.data["name"] == "IF PLAYER":
			target_types = Global.player_target_types
		
		#Clear popup menu
		target_type_menu.clear()
		
		#Add target types
		for target_type in target_types:
			target_type_menu.add_icon_item(load("res://textures/items/" + target_types[target_type]["icon"] + ".png"), target_type.capitalize())
		
		#Disconnect all signals from popup menu
		for connected_signal in target_type_menu.get_signal_connection_list("index_pressed"):
			target_type_menu.index_pressed.disconnect(connected_signal["callable"])
		
		#Connect codeblock to the popupmenu 
		target_type_menu.index_pressed.connect(_on_target_type_menu_index_pressed)
		
		#Position target type menu button
		target_type_menu_button.position = global_position + Vector2(0, 0)
		
		#Show the popup menu
		target_type_menu_button.show_popup()

#When index is selected, update target indicator
func _on_target_type_menu_index_pressed(index):
	var target_type =  target_type_menu.get_item_text(index).to_upper()
	
	codeblock.target_indicator_icon.texture = load("res://textures/items/" + target_types[target_type]["icon"] + ".png")
	codeblock.data["target"] = target_type
