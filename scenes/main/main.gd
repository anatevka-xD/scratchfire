extends Node2D

@onready var codeblock_scene = preload("res://scenes/codeblock/codeblock.tscn")
@onready var value_scene = preload("res://scenes/value/value.tscn")

@onready var codeblock_menu = $HBoxContainer/CodeblockMenu
@onready var value_menu = $HBoxContainer/ValueMenu
@onready var fps_counter = $FPSCounter
@onready var target_type_menu_button = $TargetTypeMenuButton
@onready var action_type_menu_button = $ActionTypeMenuButton

var target_type_menu
var action_type_menu

func _ready():
	Global.main = self
	target_type_menu = target_type_menu_button.get_popup()
	action_type_menu = action_type_menu_button.get_popup()
	
	#Create variable menu buttons
	for value_item in Global.value_items:
		var value_menu_button = Button.new()
		var icon = load("res://textures/items/" + Global.value_items[value_item]["item"] + ".png")
		
		value_menu_button.text = value_item.capitalize()
		value_menu_button.pressed.connect(_on_value_menu_button_pressed.bind(value_menu_button))
		value_menu_button.custom_minimum_size.y = 32
		value_menu_button.alignment = 0
		value_menu_button.icon = icon
		
		value_menu.add_child(value_menu_button)
	
	#Create codeblock menu buttons
	for category in Global.codeblocks:
		var codeblock_menu_button = Button.new()
		var icon = load("res://textures/blocks/" + Global.codeblocks[category]["material"] + ".png")
		
		codeblock_menu_button.text = category.capitalize()
		codeblock_menu_button.pressed.connect(_on_codeblock_menu_button_pressed.bind(codeblock_menu_button))
		codeblock_menu_button.custom_minimum_size.y = 32
		codeblock_menu_button.alignment = 0
		codeblock_menu_button.icon = icon
		
		codeblock_menu.add_child(codeblock_menu_button)

func _process(_delta):
	fps_counter.text = str(Engine.get_frames_per_second())

#Create codeblock
func _on_codeblock_menu_button_pressed(codeblock_menu_button):
	var codeblock_name = codeblock_menu_button.text.to_upper()
	var codeblock_data = Global.codeblocks[codeblock_name]
	codeblock_data["name"] = codeblock_name
	
	var new_codeblock = codeblock_scene.instantiate()
	
	new_codeblock.data.merge(codeblock_data)
	add_child(new_codeblock)

#Create value
func _on_value_menu_button_pressed(value_menu_button):
	var type = value_menu_button.text.to_upper()
	var new_value = value_scene.instantiate()
	
	new_value.type = type

	add_child(new_value)
