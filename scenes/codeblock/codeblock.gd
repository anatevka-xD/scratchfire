extends PanelContainer

@onready var inventory_scene = preload("res://scenes/inventory/inventory.tscn")

@onready var label = $VBoxContainer/Top/Info/HBoxContainer/CodeblockName
@onready var top_texture = $VBoxContainer/Top/Texture/HBoxContainer/Control/TextureRect
@onready var top_component = $VBoxContainer/Top
@onready var bracket_component = $VBoxContainer/Bracket
@onready var end_component = $VBoxContainer/End
@onready var inventory_indicator = $VBoxContainer/Top/Info/HBoxContainer/InventoryIndicator
@onready var action_indicator = $VBoxContainer/Top/Info/HBoxContainer/ActionIndicator
@onready var target_indicator = $VBoxContainer/Top/Info/HBoxContainer/TargetIndicator
@onready var upper_interactable = $VBoxContainer/Top/Draggable
@onready var attached = $VBoxContainer/Attached
@onready var target_indicator_icon = $VBoxContainer/Top/Info/HBoxContainer/TargetIndicator/TargetButton

@onready var modulated_nodes = [
	$VBoxContainer/Top/Texture,
	$VBoxContainer/Bracket/HBoxContainer/NinePatchRect,
	$VBoxContainer/End/Texture
]

var draggable_type = "codeblock"

var lower_interactable
var contents
var inventory

var data = {
	"action": ""
}

func _ready():
	
	#Modulate textures
	for node in modulated_nodes:
		node.modulate = data["color"]
	
	#Information that is always true across codeblock forms
	upper_interactable.parent = self
	label.text = data["name"].capitalize()
	data["target"] = "NONE"
	
	#Set up codeblock indicators
	if not data["has_inventory"]: 	
		inventory_indicator.queue_free()
	else:
		#Create inventory
		inventory = inventory_scene.instantiate()
		inventory.codeblock = self
		
		Global.main.add_child(inventory)
	
	if not data["has_target"]:
		target_indicator.queue_free()
	
	if not data["has_types"]:
		action_indicator.queue_free()
	
	#Set up conditional draggable data
	match data["form"]:
		"bracket":
			lower_interactable = $VBoxContainer/End/Draggable
			contents = $VBoxContainer/Bracket/HBoxContainer/Contents
			
			upper_interactable.body = contents
			
			upper_interactable.drop_type = "codeblock"
			upper_interactable.receive_type = "codeblock"
			
			Global.interactables.append(upper_interactable)
			
			lower_interactable.parent = self
			lower_interactable.body = attached
			
			lower_interactable.drop_type = "codeblock"
			lower_interactable.receive_type = "codeblock"
			
			Global.interactables.append(lower_interactable)
		"line":
			top_texture.texture = load("res://textures/gui/line_start.png")
			
			upper_interactable.body = attached
			
			bracket_component.queue_free()
			end_component.queue_free()
			
			upper_interactable.drop_type = "codeblock"
			upper_interactable.receive_type = "codeblock"
			
			Global.interactables.append(upper_interactable)
		"start":
			top_texture.texture = load("res://textures/gui/start_start.png")
			
			upper_interactable.body = attached
			
			bracket_component.queue_free()
			end_component.queue_free()
			
			upper_interactable.receive_type = "codeblock"
			
			Global.interactables.append(upper_interactable)

func _process(_delta):
	#Resize end of bracket to be as long as top of bracket
	if data["form"] == "bracket":
		end_component.custom_minimum_size.x = top_component.size.x


