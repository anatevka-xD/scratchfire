extends PanelContainer

var parent
var parameter

func _ready():
	hide()
	
	match parent.type:
		"STRING":
			parameter = LineEdit.new()
			parameter.expand_to_text_length = true
			parameter.placeholder_text = "String"
			parameter.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			add_child(parameter)
		"STYLED TEXT":
			parameter = LineEdit.new()
			parameter.expand_to_text_length = true
			parameter.placeholder_text = "Styled Text"
			parameter.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			add_child(parameter)
		"NUMBER":
			parameter = SpinBox.new()
			parameter.max_value = 9223372036854775
			parameter.min_value = -9223372036854775
			parameter.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			parameter.step = 0.001
			
			parameter.get_line_edit().expand_to_text_length = true
			parameter.get_line_edit().size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			
			add_child(parameter)
		"LOCATION":
			parameter = HBoxContainer.new()
			parameter.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			
			var spinbox
			
			spinbox = SpinBox.new()
			
			spinbox.max_value = 9223372036854775
			spinbox.min_value = -9223372036854775
			spinbox.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			spinbox.step = 0.001
			
			spinbox.get_line_edit().expand_to_text_length = true
			spinbox.get_line_edit().size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			
			parameter.add_child(spinbox)
			
			spinbox = SpinBox.new()
			
			spinbox.max_value = 9223372036854775
			spinbox.min_value = -9223372036854775
			spinbox.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			spinbox.step = 0.001
			
			spinbox.get_line_edit().expand_to_text_length = true
			spinbox.get_line_edit().size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			
			parameter.add_child(spinbox)
			
			spinbox = SpinBox.new()
			
			spinbox.max_value = 9223372036854775
			spinbox.min_value = -9223372036854775
			spinbox.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			spinbox.step = 0.001
			
			spinbox.get_line_edit().expand_to_text_length = true
			spinbox.get_line_edit().size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
			
			parameter.add_child(spinbox)
			
			add_child(parameter)

func _process(_delta):
	global_position = parent.global_position + Vector2(34, 0)
