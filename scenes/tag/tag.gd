extends PanelContainer

@onready var option_button = $Control/Options
@onready var item = $TextureRect

var tag 
var options

func set_initial_texture():
	item.texture = option_button.get_item_icon(1)

func _on_options_item_selected(index):
	item.texture = option_button.get_item_icon(index)
