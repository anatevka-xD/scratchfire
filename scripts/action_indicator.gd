extends HBoxContainer

var action_type_menu = Global.main.action_type_menu
var action_type_menu_button = Global.main.action_type_menu_button

@onready var codeblock = $"../../../../.."

var codeblock_name

func _ready():
	codeblock_name = codeblock.data["name"]

func _on_action_button_pressed():
	#Disconnect all signals from popup menu
	for connected_signal in action_type_menu.get_signal_connection_list("index_pressed"):
		action_type_menu.index_pressed.disconnect(connected_signal["callable"])
	
	#Set up variables to help create popup menu items
	var codeblock_categories = Global.codeblock_categories[codeblock_name]
	var associated_actions = Global.codeblock_actions[codeblock_name].duplicate()
	var icon
	
	#Clear popup menu
	action_type_menu.clear(true)
	
	#Setup category submenus
	for category in codeblock_categories:
		var submenu = PopupMenu.new()
		
		submenu.set_name(Global.strip_color(category))
		submenu.index_pressed.connect(_on_action_type_menu_index_pressed.bind(submenu))
		
		action_type_menu.add_child(submenu)
		
		action_type_menu.add_submenu_item(Global.strip_color(category), Global.strip_color(category))
		
		for action in codeblock_categories[category]:
			var action_display_name = Global.codeblock_actions[codeblock_name][action]["icon"]["name"]
			var icon_material = Global.codeblock_actions[codeblock_name][action]["icon"]["material"]
			
			if not action_display_name.contains("(Old)"):
				icon = load("res://textures/items/" + icon_material + ".png")
				
				associated_actions.erase(action)
				
				submenu.add_icon_item(icon, Global.strip_color(action_display_name))
	
	#Add additional actions not in categories
	for action in associated_actions:
		var action_display_name = Global.codeblock_actions[codeblock_name][action]["icon"]["name"]
		var icon_material = Global.codeblock_actions[codeblock_name][action]["icon"]["material"]
		
		if action_display_name != "":
			if not Global.legacy_codeblocks.has(associated_actions[action]["name"]):
				if not action_display_name.contains("(Old)"):
					icon = load("res://textures/items/" + icon_material + ".png")
					
					action_type_menu.add_icon_item(icon, Global.strip_color(action_display_name))
	
	#Connect codeblock to the popupmenu 
	action_type_menu.index_pressed.connect(_on_action_type_menu_index_pressed.bind(action_type_menu))
	
	#Position target type menu button
	action_type_menu_button.position = global_position + Vector2(0, 0)
	
	#Show the popup menu
	action_type_menu_button.show_popup()

#When index is selected, update target indicator
func _on_action_type_menu_index_pressed(index, menu):
	var action_type =  menu.get_item_text(index)
	
	#Update codeblock label
	codeblock.label.text = action_type
	
	#Set codeblock action name
	for action in Global.codeblock_actions[codeblock_name]:
		var action_display_name = Global.strip_color(Global.codeblock_actions[codeblock_name][action]["icon"]["name"])
		
		if action_type == action_display_name:
			var _old_action = codeblock.data["action"]
			var _old_name = codeblock.data["name"]
			
			codeblock.data["action"] = action
			
			if codeblock.data["has_inventory"]:
				codeblock.inventory.update_tags(_old_name, _old_action)
			
			break

