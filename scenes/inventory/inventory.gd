extends Control

@onready var slot_scene = preload("res://scenes/slot/slot.tscn")

@onready var inventory = $VBoxContainer/GridContainer
@onready var anchor_line = $Line2D
@onready var interactable = $Draggable

var draggable_type = "inventory"

var placement = "snap"

var codeblock
var contents
var offset

func _ready():
	hide()
	
	interactable.parent = self
	Global.interactables.append(interactable)
	
	for i in range(0, 27):
		var slot = slot_scene.instantiate()
		inventory.add_child(slot)

func _process(_delta):
	var codeblock_offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0)
	var inventory_offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0) - global_position
	
	if placement == "snap":
		global_position = codeblock_offset
	
	if placement == "float":
		global_position = codeblock_offset - offset
		
		draw_anchor_line(anchor_line, anchor_line.position, inventory_offset)
	
	if placement == "fix":
		draw_anchor_line(anchor_line, anchor_line.position, inventory_offset)

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
