extends ValueEditMenu

@onready var game_value_type_button : Button = $VBoxContainer/GameValueTypeButton
@onready var target_button : OptionButton = $VBoxContainer/HBoxContainer/TargetButton

var game_value_type_menu = Global.main.sound_type_menu
var game_value_type_menu_button = Global.main.sound_type_menu_button

var game_value

func setup():
	for target in Global.target_types:
		var icon = load("res://textures/items/" + Global.target_types[target]["icon"] + ".png")
		target_button.add_icon_item(icon, target.capitalize())

func _on_game_value_type_button_pressed():
	#Disconnect all signals from popup menu
	for connected_signal in game_value_type_menu.get_signal_connection_list("index_pressed"):
		game_value_type_menu.index_pressed.disconnect(connected_signal["callable"])
	
	#Connect value to the popupmenu 
	game_value_type_menu.index_pressed.connect(_on_game_value_type_menu_index_pressed.bind(game_value_type_menu))
	
	#Clear popup menu
	game_value_type_menu.clear(true)
	
	#Create categories
	for category in Global.game_value_categories:
		var submenu = PopupMenu.new()
		
		submenu.set_name(category)
		submenu.index_pressed.connect(_on_game_value_type_menu_index_pressed.bind(submenu))
		
		game_value_type_menu.add_child(submenu)
		
		game_value_type_menu.add_submenu_item(category, category)
		
		for value in Global.game_value_categories[category]:
			var icon_material = Global.game_values[value]["icon"]["material"]
			var icon = load("res://textures/items/" + icon_material + ".png")
			
			submenu.add_icon_item(icon, value)
	
	#Position target type menu button
	game_value_type_menu_button.position = global_position + Vector2(0, 0)
	
	#Show the popup menu
	game_value_type_menu_button.show_popup()

func _on_game_value_type_menu_index_pressed(index, menu):
	var value = menu.get_item_text(index)
	
	game_value = value
	game_value_type_button.text = game_value

