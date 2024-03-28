extends Control

@onready var slot_scene = preload("res://scenes/slot/slot.tscn")
@onready var tag_scene = preload("res://scenes/tag/tag.tscn")

@onready var inventory = $HBoxContainer/GridContainer
@onready var anchor_line = $Line2D
@onready var interactable = $Draggable
@onready var snap_button = $HBoxContainer/PlacementButtons/Snap
@onready var float_button = $HBoxContainer/PlacementButtons/Float
@onready var fix_button = $HBoxContainer/PlacementButtons/Fix

@onready var offset = codeblock.global_position + Vector2(codeblock.top_component.size.x, 0) - global_position

var draggable_type = "inventory"

var placement = "snap"

var codeblock
var contents

func _ready():
	hide()
	
	interactable.parent = self
	Global.inventories.append(interactable)
	
	for i in range(0, 27):
		var slot = slot_scene.instantiate()
		slot.id = i
		slot.name = "slot" + str(i)
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
		
		draw_anchor_line(anchor_line, anchor_line.position + Vector2(0, 16), inventory_offset)
	if placement == "fix":
		snap_button.disabled = false
		fix_button.disabled = true
		float_button.disabled = false
		
		draw_anchor_line(anchor_line, anchor_line.position + Vector2(0, 16), inventory_offset)

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

func update_tags(_old_name, _old_action):
	var _action = codeblock.data["action"]
	var _name = codeblock.data["name"]
	
	var old_tags = []
	if not _old_action == "":
		old_tags = Global.codeblock_actions[_old_name][_old_action]["tags"]
	
	var tags = Global.codeblock_actions[_name][_action]["tags"]
	
	var old_tag_count = old_tags.size()
	var tag_count = tags.size()
	
	print(old_tag_count)
	print(tag_count)
	
	var slots = inventory.get_children()
	
	for i in range((27 - old_tag_count), 27):
		var slot = slots[i]
		for child in slot.contents.get_children():
			child.queue_free()
	
	var j = 0
	for i in range((27 - tag_count), 27):
		var slot = slots[i]
		
		var new_tag = tag_scene.instantiate()
		new_tag.scale = Vector2(0.5, 0.5)
		
		var tag = tags[j]["name"]
		new_tag.tag = tag
		
		slot.contents.add_child(new_tag)
		
		new_tag.option_button.add_separator(tag)
		
		for option in tags[j]["options"]:
			new_tag.option_button.add_icon_item(load("res://textures/items/" + option["icon"]["material"] + ".png"), option["name"])
		
		new_tag.set_initial_texture()
		
		j += 1


