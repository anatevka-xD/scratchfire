extends HBoxContainer

@onready var codeblock = $"../../../../.."

func _on_panel_container_gui_input(event):
	if not(event is InputEventMouseButton): return
	if !event.is_pressed(): return
	if event.get_button_index() == 2:
		if codeblock.inventory.is_visible():
			codeblock.inventory.hide()
		else:
			codeblock.inventory.show()
