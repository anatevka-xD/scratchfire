extends ValueEditMenu

@onready var sound_type_button : Button = $VBoxContainer/SoundTypeButton
@onready var variant_button : OptionButton = $VBoxContainer/HBoxContainer/VariantButton

var sound_type_menu = Global.main.sound_type_menu
var sound_type_menu_button = Global.main.sound_type_menu_button

var sound
var variant
var pitch 
var volume

func setup():
	pass

func _on_sound_type_button_pressed():
	#Disconnect all signals from popup menu
	for connected_signal in sound_type_menu.get_signal_connection_list("index_pressed"):
		sound_type_menu.index_pressed.disconnect(connected_signal["callable"])
	
	#Connect value to the popupmenu 
	sound_type_menu.index_pressed.connect(_on_sound_type_menu_index_pressed.bind(sound_type_menu))
	
	#Position target type menu button
	sound_type_menu_button.position = global_position + Vector2(0, 0)
	
	#Show the popup menu
	sound_type_menu_button.show_popup()

func _on_sound_type_menu_index_pressed(index, menu):
	var sound_name = menu.get_item_text(index)
	sound = sound_name.replace(" ", "_").to_upper()
	
	var variant_count = Global.strip_color(Global.sounds[sound]["icon"]["description"][0])
	var array = variant_count.split(" ")
	variant_count = int(array[0])
	
	variant_button.clear()
	
	for i in variant_count:
		variant_button.add_item(str(i + 1))
	
	sound_type_button.text = sound_name

