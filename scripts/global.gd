extends Node2D

var parameter_types = {
	"STRING VALUE": 		{"item": "STRING",},
	"STYLED TEXT VALUE": 	{"item": "BOOK"},
	"NUMBER VALUE": 		{"item": "SLIME_BALL"},
	"LOCATION VALUE": 		{"item": "PAPER"},
	"VECTOR VALUE": 		{"item": "PRISMARINE_SHARD"},
	"SOUND VALUE": 			{"item": "NAUTILUS_SHELL"},
	"PARTICLE VALUE": 		{"item": "WHITE_DYE"},
	"POTION EFFECT VALUE": 	{"item": "DRAGON_BREATH"},
	"ITEM VALUE": 			{"item": "ITEM_FRAME"},
	"ANY VALUE":			{"item": "POTATO"},
	"VARIABLE VALUE":		{"item": "MAGMA_CREAM"},
	"LIST VALUE":			{"item": "SKULL_BANNER_PATTERN"},
	"DICTIONARY VALUE": 	{"item": "KNOWLEDGE_BOOK"}
}

var valid_game_value_categories = [
	"Statistical Values",
	"Locational Values",
	"Item Values",
	"Informational Values",
	"Event Values",
	"Plot Values"
]

var codeblock_category_display_names = {
	"Player Action Categories": "PLAYER ACTION",
	"If Player Categories": "IF PLAYER",
	"Control Actions": "CONTROL",
	"Set Variable Categories": "SET VARIABLE",
	"Entity Events": "ENTITY EVENT",
	"Player Event Categories": "PLAYER EVENT",
	"If Entity Conditions": "IF ENTITY",
	"Entity Action Categories": "ENTITY ACTION",
	"If Variable Conditions": "IF VARIABLE",
	"Select Object": "SELECT OBJECT",
	"Game Action Categories": "GAME ACTION",
	"Repeat Functions": "REPEAT",
	"If Game Conditions": "IF GAME"
}

var codeblocks = {
	"PLAYER EVENT": 	{"form": "start", 	"has_inventory": false, "has_target": false, 	"has_types": true, 	"color": Color("#62ede4"), "material": "DIAMOND_BLOCK"},
	"PLAYER ACTION": 	{"form": "line", 	"has_inventory": true, 	"has_target": true, 	"has_types": true, 	"color": Color("#7f7f7f"), "material": "COBBLESTONE"},
	"IF PLAYER": 		{"form": "bracket", "has_inventory": true, 	"has_target": true, 	"has_types": true, 	"color": Color("#a2824e"), "material": "OAK_PLANKS"},
	"ENTITY EVENT": 	{"form": "start", 	"has_inventory": false, "has_target": false, 	"has_types": true, 	"color": Color("#f6d03d"), "material": "GOLD_BLOCK"},
	"ENTITY ACTION": 	{"form": "line", 	"has_inventory": true, 	"has_target": true, 	"has_types": true, 	"color": Color("#6e765e"), "material": "MOSSY_COBBLESTONE"},
	"IF ENTITY": 		{"form": "bracket", "has_inventory": true, 	"has_target": true, 	"has_types": true, 	"color": Color("#966153"), "material": "BRICKS"},
	"GAME ACTION": 		{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#612626"), "material": "NETHERRACK"},
	"IF GAME": 			{"form": "bracket", "has_inventory": true,	"has_target": false, 	"has_types": true, 	"color": Color("#450709"), "material": "RED_NETHER_BRICKS"},
	"SET VARIABLE": 	{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#dcdcdc"), "material": "IRON_BLOCK"},
	"IF VARIABLE": 		{"form": "bracket", "has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#372851"), "material": "OBSIDIAN"},
	"FUNCTION": 		{"form": "start", 	"has_inventory": true, 	"has_target": false, 	"has_types": false, "color": Color("#2A5CC9"), "material": "LAPIS_BLOCK"},
	"CALL FUNCTION": 	{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": false, "color": Color("#7CA6FF"), "material": "LAPIS_ORE"},
	"PROCESS": 			{"form": "start", 	"has_inventory": true, 	"has_target": false, 	"has_types": false, "color": Color("#2acb57"), "material": "EMERALD_BLOCK"},
	"START PROCESS": 	{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": false, "color": Color("#89FF7C"), "material": "EMERALD_ORE"},
	"SELECT OBJECT": 	{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#a97da9"), "material": "PURPUR_BLOCK"},
	"REPEAT": 			{"form": "bracket", "has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#62a291"), "material": "PRISMARINE"},
	"CONTROL": 			{"form": "line", 	"has_inventory": true, 	"has_target": false, 	"has_types": true, 	"color": Color("#353232"), "material": "COAL_BLOCK"},
	"ELSE": 			{"form": "bracket", "has_inventory": false, "has_target": false, 	"has_types": false, "color": Color("#dbde9e"), "material": "END_STONE"}
}

var color_codes = {
	"§0": "#000000",
	"§8": "#545454",
	"§7": "#A8A8A8",
	"§f": "#FCFCFC",
	"§1": "#0000A8",
	"§9": "#5454FC",
	"§3": "#00A8A8",
	"§b": "#54FCFC",
	"§2": "#00A800",
	"§a": "#54FC54",
	"§4": "#A80000",
	"§c": "#FC5454",
	"§6": "#FCA800",
	"§e": "#FCFC54",
	"§5": "#A800A8",
	"§d": "#FC54FC"
}

var value_items = {
	"STRING": 			{"item": "STRING",},
	"STYLED TEXT": 		{"item": "BOOK"},
	"NUMBER": 			{"item": "SLIME_BALL"},
	"LOCATION": 		{"item": "PAPER"},
	"VECTOR": 			{"item": "PRISMARINE_SHARD"},
	"SOUND": 			{"item": "NAUTILUS_SHELL"},
	"PARTICLE": 		{"item": "WHITE_DYE"},
	"POTION EFFECT": 	{"item": "DRAGON_BREATH"},
	"VARIABLE": 		{"item": "MAGMA_CREAM"},
	"GAME VALUE": 		{"item": "NAME_TAG"},
	"PARAMETER": 		{"item": "ENDER_EYE"}
}

var player_target_types = {
	"NONE": {"icon": "GRAY_BARRIER"},
	"CURRENT SELECTION": {"icon": "NETHER_STAR"},
	"DEFAULT PLAYER": {"icon": "POTATO"},
	"KILLER PLAYER": {"icon": "IRON_SWORD"},
	"DAMAGER PLAYER": {"icon": "STONE_SWORD"},
	"SHOOTER PLAYER": {"icon": "BOW"},
	"VICTIM PLAYER": {"icon": "SKELETON_SKULL"},
	"ALL PLAYERS": {"icon": "BEACON"}
}

var entity_target_types = {
	"NONE": {"icon": "GRAY_BARRIER"},
	"CURRENT SELECTION": {"icon": "NETHER_STAR"},
	"DEFAULT ENTITY": {"icon": "POTATO"},
	"KILLER ENTITY": {"icon": "IRON_SWORD"},
	"DAMAGER ENTITY": {"icon": "STONE_SWORD"},
	"VICTIM ENTITY": {"icon": "SKELETON_SKULL"},
	"SHOOTER ENTITY": {"icon": "BOW"},
	"PROJECTILE": {"icon": "ARROW"},
	"ALL ENTITIES": {"icon": "DIAMOND_BLOCK"},
	"ALL MOBS": {"icon": "BEACON"},
	"LAST ENTITY SPAWNED": {"icon": "TURTLE_EGG"}
}

var target_types = {
	"NONE": {"icon": "GRAY_BARRIER"},
	"CURRENT SELECTION": {"icon": "NETHER_STAR"},
	"DEFAULT TARGET": {"icon": "POTATO"},
	"KILLER TARGET": {"icon": "IRON_SWORD"},
	"DAMAGER TARGET": {"icon": "STONE_SWORD"},
	"VICTIM TARGET": {"icon": "SKELETON_SKULL"},
	"SHOOTER TARGET": {"icon": "BOW"},
	"PROJECTILE": {"icon": "ARROW"},
	"LAST ENTITY SPAWNED": {"icon": "TURTLE_EGG"}
}

var legacy_codeblocks = [
	"SetXPProg",
	"TpSequence",
	"ForceFlight",
	"SetAbsorption",
	"RngTeleport",
	"WalkSpeed",
	"SetNameVisible",
	"SetName"
]

var enchantments = [
	"AQUA_AFFINITY",
	"BANE_OF_ARTHROPODS",
	"BINDING_CURSE",
	"BLAST_PROTECTION",
	"CHANNELING",
	"DEPTH_STRIDER",
	"EFFICIENCY",
	"FEATHER_FALLING",
	"FIRE_ASPECT",
	"FIRE_PROTECTION",
	"FLAME",
	"FORTUNE",
	"FROST_WALKER",
	"IMPALING",
	"INFINITY",
	"KNOCKBACK",
	"LOOTING",
	"LOYALTY",
	"LUCK_OF_THE_SEA",
	"LURE",
	"MENDING",
	"MULTISHOT",
	"PIERCING",
	"POWER",
	"PROJECTILE_PROTECTION",
	"PROTECTION",
	"PUNCH",
	"QUICK_CHARGE",
	"RESPIRATION",
	"RIPTIDE",
	"SHARPNESS",
	"SILK_TOUCH",
	"SMITE",
	"SOUL_SPEED",
	"SWEEPING_EDGE",
	"SWIFT_SNEAK",
	"THORNS",
	"UNBREAKING",
	"VANISHING_CURSE"
]

var json = JSON.parse_string(FileAccess.get_file_as_string("res://json/actiondump.json"))

var selected_object : Node
var main : Node

var selected_offset : Vector2
var click_location : Vector2

var codeblock_actions : Dictionary
var codeblock_categories : Dictionary
var sounds : Dictionary
var particles : Dictionary
var potions : Dictionary
var game_values : Dictionary
var game_value_categories : Dictionary

var interactables : Array
var inventories : Array
var values : Array
var items : Array
var item_types : Array

var dragging = false

func _ready():
	for codeblock_name in codeblocks:
		codeblock_actions[codeblock_name] = {}
		codeblock_categories[codeblock_name] = {}
	
	#Get all actions associated with codeblock
	for action in json["actions"]:
		codeblock_actions[action["codeblockName"]][action["name"]] = action
	
	#Set up codeblock categories
	for categories in json["codeblockCategories"]:
		var categories_name = categories["name"]
		var codeblock_name = codeblock_category_display_names[categories_name]
		
		var category_dictionary = {}
		
		for category in categories["categories"]:
			var category_name = strip_color(category["name"])
			var category_actions = category["actions"]
			category_dictionary[category_name] = category_actions
		
		codeblock_categories[codeblock_name] = category_dictionary
	
	#Set up sounds dictionary
	for sound in json["sounds"]:
		sounds[sound["sound"]] = sound
	
	#Set up particles dictionary
	for particle in json["particles"]:
		if particle["category"] != null:
			particles[particle["particle"]] = particle
	
	#Set up potions dictionary
	for potion in json["potions"]:
		potions[potion["potion"]] = potion
	
	#Set up game value categories dictionary
	for category in json["gameValueCategories"]:
		var category_name = category["identifier"]
		if valid_game_value_categories.has(category_name):
			game_value_categories[category_name] = []
	
	#Set up game value dictionary
	for value in json["gameValues"]:
		var value_name = strip_color(value["icon"]["name"])
		game_values[value_name] = value
		var category = value["category"]
		
		game_value_categories[category].append(value_name)
	
	#Set up item types array
	var dir = DirAccess.open("res://textures/items/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "AIR.png":
				if !file_name.contains(".import"):
					item_types.append(file_name.replace(".png", ""))
					
			file_name = dir.get_next()

func _process(_delta):
	#Update selected object's position
	if selected_object != null:
		if selected_object.draggable_type == "codeblock":
			drag_codeblock()
		if selected_object.draggable_type == "inventory":
			drag_inventory()
		if selected_object.draggable_type == "value":
			drag_value()
	
	#Let go of selected object
	if Input.is_action_just_released("LeftMouse"):
		if selected_object != null:
			#Handle codeblock dragging
			if selected_object.draggable_type == "codeblock":
				drop_codeblock()
			
			if selected_object.draggable_type == "value":
				drop_value()
			
			#Deselect object
			dragging = false
			selected_object = null
	
	#Get all items
	var dir = DirAccess.open("res://textures/items/")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if not file_name.contains("AIR") && not file_name.contains("GRAY_BARRIER") && not file_name.contains(".import"):
			items.append(file_name.replace(".png", ""))
		
		file_name = dir.get_next()

#Select object
func _button_down(draggable):
	#Select object
	var clicked_object = draggable.parent
	
	if clicked_object.draggable_type == "codeblock":
		select_codeblock(clicked_object)
	
	if clicked_object.draggable_type == "inventory":
		select_inventory(clicked_object)
	
	if clicked_object.draggable_type == "value":
		select_value(clicked_object)

##Functions that control dragging
#Inventories
func select_inventory(clicked_object):
	if clicked_object.placement != "snap":
		dragging = true
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()
		selected_object.move_to_front()
	else:
		click_location = get_global_mouse_position()
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()

func drag_inventory():
	if dragging:
		selected_object.global_position = selected_offset + get_global_mouse_position()
		
		if selected_object.placement == "float":
			selected_object.offset = selected_object.codeblock.global_position + Vector2(selected_object.codeblock.top_component.size.x, 0) - selected_object.global_position
	else:
		if click_location.distance_to(get_global_mouse_position()) > 10:
			dragging = true
			
			selected_object.offset = selected_object.codeblock.global_position + Vector2(selected_object.codeblock.top_component.size.x, 0) - selected_object.global_position
			selected_object.placement = "float"
			selected_object.snap_button.disabled = true
			selected_object.fix_button.disabled = false
			selected_object.float_button.disabled = false
			selected_object.anchor_line.show()
			selected_object.reparent(main)

#Codeblocks
func drop_codeblock():
	var mouse_position = get_global_mouse_position()
	var hovered_interactables = []
	var selected_interactable
	
	#Get interactables the mouse is over
	for interactable in interactables:
		var interactable_rect = Rect2(to_global(interactable.global_position), interactable.size)
		if interactable_rect.has_point(mouse_position):
			if interactable.parent != selected_object:
				hovered_interactables.append(interactable)
			else:
				selected_interactable = interactable
	
	if hovered_interactables.size() > 0:
		#Select topmost interactable
		var top_interactable = hovered_interactables[0]
		
		for interactable in hovered_interactables:
			if interactable.parent.get_index() > top_interactable.parent.get_index():
				top_interactable = interactable
		
		#If the object can be dropped onto the topmost interactable
		#Sometimes one or the other is null, resulting in a crash
		if top_interactable && selected_interactable:
			if top_interactable.receive_type == selected_interactable.drop_type:
				#If the object is a codeblock
				if selected_interactable.drop_type == "codeblock":
						var selected_children = selected_object.attached.get_children()
						var target_children = top_interactable.body.get_children()
						
						#If the selected object and the target object both have child objects
						if !selected_children.is_empty() && !target_children.is_empty():
							
							var last_child = null
							
							while not selected_children.is_empty():
								last_child = selected_children[0]
								selected_children = selected_children[0].attached.get_children()
							
							#Parent target children to end of selected codeblock's children
							target_children[0].reparent(last_child.attached)
						#If only the top interactable has children
						elif !target_children.is_empty():
							#Parent target children to selected codeblock
							target_children[0].reparent(selected_object.attached)
						
						#Add selected codeblock to target codeblock
						selected_object.reparent(top_interactable.body)
		else:
			print(top_interactable.parent)
			print(selected_interactable.parent)

func select_codeblock(clicked_object):
	if clicked_object.get_parent() == main:
		dragging = true
		
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()
		selected_object.move_to_front()
		
		if selected_object.inventory:
			selected_object.inventory.move_to_front()
	else:
		click_location = get_global_mouse_position()
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()

func drag_codeblock():
	if dragging:
		selected_object.global_position = selected_offset + get_global_mouse_position()
	else:
		if click_location.distance_to(get_global_mouse_position()) > 10:
			dragging = true
			
			selected_object.reparent(main)
			selected_object.move_to_front()
			
			if selected_object.inventory:
				selected_object.inventory.move_to_front()

#Values
func drop_value():
	var mouse_position = get_global_mouse_position()
	var hovered_inventories = []
	var selected_inventory
	
	#Get inventories the mouse is over
	for inventory in inventories:
		var inventory_rect = Rect2(to_global(inventory.global_position), inventory.size)
		if inventory_rect.has_point(mouse_position):
			hovered_inventories.append(inventory)
	
	if hovered_inventories.size() > 0:
		#Select topmost inventory
		var top_inventory = hovered_inventories[0]
		
		for inventory in hovered_inventories:
			if inventory.parent.get_index() > top_inventory.parent.get_index():
				top_inventory = inventory
		
		#Get slot the mouse is over
		var slots = top_inventory.parent.inventory.get_children()
		var hovered_slot
		
		for slot in slots:
			var slot_rect = Rect2(to_global(slot.global_position), slot.size)
			if slot_rect.has_point(mouse_position):
				hovered_slot = slot
		
		if hovered_slot.contents.get_children().size() == 0:
			selected_object.custom_minimum_size = Vector2(16, 16)
			selected_object.reparent(hovered_slot)

func select_value(clicked_object):
	if clicked_object.get_parent() == main:
		dragging = true
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()
		selected_object.move_to_front()
	else:
		click_location = get_global_mouse_position()
		selected_object = clicked_object
		selected_offset = selected_object.global_position - get_global_mouse_position()

func drag_value():
	if dragging:
		selected_object.global_position = selected_offset + get_global_mouse_position()
	else:
		if click_location.distance_to(get_global_mouse_position()) > 10:
			dragging = true
			
			selected_object.reparent(main)
			selected_object.custom_minimum_size = Vector2(32, 32)

#Utility functions

func strip_color(text : String):
	if text.begins_with("§x"):
		var string = text.substr(14, -1)
		return string
	elif text.begins_with("§"):
		var string = text.substr(2, -1)
		return string
	else:
		return text
