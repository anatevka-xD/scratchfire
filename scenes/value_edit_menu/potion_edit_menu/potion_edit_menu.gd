extends ValueEditMenu

@onready var potion_type_button : Button = $VBoxContainer/PotionTypeButton

var potion_type_menu = Global.main.potion_type_menu
var potion_type_menu_button = Global.main.potion_type_menu_button

var potion

func setup():
	pass

func _on_potion_type_button_pressed():
	#Disconnect all signals from popup menu
	for connected_signal in potion_type_menu.get_signal_connection_list("index_pressed"):
		potion_type_menu.index_pressed.disconnect(connected_signal["callable"])
	
	#Connect value to the popupmenu 
	potion_type_menu.index_pressed.connect(_on_potion_type_menu_index_pressed.bind(potion_type_menu))
	
	#Position target type menu button
	potion_type_menu_button.position = global_position + Vector2(0, 0)
	
	#Show the popup menu
	potion_type_menu_button.show_popup()

func _on_potion_type_menu_index_pressed(index, menu):
	var potion_name = menu.get_item_text(index)
	potion = potion_name.replace(" ", "_").to_upper()
	
	potion_type_button.text = potion_name

