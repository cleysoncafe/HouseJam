extends Button

var pause_controller: Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_STOP
	focus_mode = Control.FOCUS_ALL
	
	# Find the pause controller node
	pause_controller = get_node("Pauseinventory") # Adjust this path to match your scene structure
	
	# Connect the pressed signal
	if !pressed.is_connected(_on_pressed):
		pressed.connect(_on_pressed)

func _on_pressed():
	if pause_controller:
		if get_tree().paused:
			pause_controller._do_unpause()
		else:
			pause_controller._do_pause()
