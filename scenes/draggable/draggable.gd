extends Button

var parent 
var body

var drop_type = null
var receive_type = null

func _ready():
	button_down.connect(Callable(Global, "_button_down").bind(self))
