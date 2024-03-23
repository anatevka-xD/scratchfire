extends Control

@onready var slot_scene = preload("res://scenes/slot/slot.tscn")

@onready var inventory = $HBoxContainer/GridContainer
@onready var anchor_line = $Line2D
@onready var interactable = $Draggable
@onready var snap_button = $HBoxContainer/PlacementButtons/Snap
@onready var float_button = $HBoxContainer/PlacementButtons/Float
@onready var fix_button = $HBoxContainer/PlacementButtons/Fix

var draggable_type = "inventory"

var placement = "snap"

var codeblock
var contents
@onready var offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0) - global_position

func _ready():
	hide()
	
	interactable.parent = self
	
	for i in range(0, 27):
		var slot = slot_scene.instantiate()
		inventory.add_child(slot)

func _process(_delta):
	var codeblock_offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0)
	var inventory_offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 16) - global_position
	
	
	if placement == "snap":
		global_position = codeblock_offset
		
		snap_button.disabled = true
		fix_button.disabled = false
		float_button.disabled = false
	
	if placement == "float":
		global_position = codeblock_offset - offset
		
		snap_button.disabled = false
		fix_button.disabled = false
		float_button.disabled = true
		
		draw_anchor_line(anchor_line, anchor_line.position + Vector2(0, 32), inventory_offset)
	
	if placement == "fix":
		snap_button.disabled = false
		fix_button.disabled = true
		float_button.disabled = false
		
		draw_anchor_line(anchor_line, anchor_line.position + Vector2(0, 32), inventory_offset)

func _on_snap_pressed():
	placement = "snap"
	anchor_line.hide()

func _on_float_pressed():
	placement = "float"
	anchor_line.show()
	
	offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0) - global_position

func _on_fix_pressed():
	placement = "fix"
	anchor_line.show()

func draw_anchor_line(line : Line2D, point_a, point_b):
	line.set_point_position(0, point_a)
	line.set_point_position(1, point_b)
