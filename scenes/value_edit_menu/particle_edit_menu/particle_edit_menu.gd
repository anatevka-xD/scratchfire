extends ValueEditMenu

@onready var particle_type_button : Button = $VBoxContainer/ParticleTypeButton
@onready var fields_container : VBoxContainer = $VBoxContainer/VBoxContainer
@onready var field_input = preload("res://scenes/value_edit_menu/particle_edit_menu/field_input.tscn")

var particle_type_menu = Global.main.particle_type_menu
var particle_type_menu_button = Global.main.particle_type_menu_button

var fields : Array

var particle

func setup():
	pass

func _on_particle_type_button_pressed():
	#Disconnect all signals from popup menu
	for connected_signal in particle_type_menu.get_signal_connection_list("index_pressed"):
		particle_type_menu.index_pressed.disconnect(connected_signal["callable"])
	
	#Connect value to the popupmenu 
	particle_type_menu.index_pressed.connect(_on_particle_type_menu_index_pressed.bind(particle_type_menu))
	
	#Position target type menu button
	particle_type_menu_button.position = global_position + Vector2(0, 0)
	
	#Show the popup menu
	particle_type_menu_button.show_popup()

func _on_particle_type_menu_index_pressed(index, menu):
	var particle_name = menu.get_item_text(index)
	particle = particle_name.replace(" ", "_").to_upper()
	
	fields = ["Amount", "Spread"]
	fields.append_array(Global.particles[particle]["fields"])
	for child in fields_container.get_children():
		child.queue_free()
	
	for field in fields:
		var new_field_input = field_input.instantiate()
		fields_container.add_child(new_field_input)
		new_field_input.label.text = field + ":"
		
		match field:
			"Amount":
				new_field_input.line_edit.text = "1"
				new_field_input.line_edit.placeholder_text = "1"
			"Spread":
				new_field_input.line_edit.text = "0.0 0.0"
				new_field_input.line_edit.placeholder_text = "0.0 0.0"
			"Motion":
				new_field_input.line_edit.text = "1.0 0.0 0.0"
				new_field_input.line_edit.placeholder_text = "1.0 0.0 0.0"
			"Motion Variation":
				new_field_input.line_edit.text = "100%"
				new_field_input.line_edit.placeholder_text = "100%"
			"Material":
				new_field_input.line_edit.text = "oak_log"
				new_field_input.line_edit.placeholder_text = "oak_log"
			"Color":
				new_field_input.line_edit.text = "#FFFFFF"
				new_field_input.line_edit.placeholder_text = "#FFFFFF"
			"Color Variation":
				new_field_input.line_edit.text = "0%"
				new_field_input.line_edit.placeholder_text = "0%"
			"Size":
				new_field_input.line_edit.text = "1.0"
				new_field_input.line_edit.placeholder_text = "1.0"
			"Size Variation":
				new_field_input.line_edit.text = "0%"
				new_field_input.line_edit.placeholder_text = "0%"
	
	particle_type_button.text = particle_name 
	
