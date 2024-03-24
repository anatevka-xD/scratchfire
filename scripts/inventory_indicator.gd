extends HBoxContainer

@onready var codeblock = $"../../../../.."

func _on_inventory_button_pressed():
	if codeblock.inventory.is_visible():
		codeblock.inventory.hide()
	else:
		codeblock.inventory.show()
