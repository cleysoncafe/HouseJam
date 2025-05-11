extends Node2D

@onready var inventory_panel = $"."
@onready var pause_button = $"../PauseButton"

var is_paused = false

func _ready():
	# Set everything to process always
	process_mode = Node.PROCESS_MODE_ALWAYS
	pause_button.process_mode = Node.PROCESS_MODE_ALWAYS
	
	inventory_panel.visible = false
	pause_button.text = "Pausar"
	
	# Remove any existing connections first
	if pause_button.pressed.is_connected(_on_pause_button_pressed):
		pause_button.pressed.disconnect(_on_pause_button_pressed)
	
	# Reconnect the signal
	pause_button.pressed.connect(_on_pause_button_pressed)
	
	# Make sure button is interactive
	pause_button.mouse_filter = Control.MOUSE_FILTER_STOP
	pause_button.focus_mode = Control.FOCUS_ALL

func _input(event):
	if event.is_action_pressed("PauseButton") or event.is_action_pressed("CancelButton"):
		_handle_pause_toggle()
		get_viewport().set_input_as_handled()

# Separate function for handling pause toggle
func _handle_pause_toggle():
	print("Handling pause toggle")  # Debug print
	if is_paused:
		_do_unpause()
	else:
		_do_pause()

# Button signal handler
func _on_pause_button_pressed() -> void:
	print("Button pressed")  # Debug print
	_handle_pause_toggle()

# Actual pause implementation
func _do_pause() -> void:
	print("Pausing game")  # Debug print
	is_paused = true
	inventory_panel.visible = true
	pause_button.text = "Retomar"
	get_tree().paused = true

# Actual unpause implementation
func _do_unpause() -> void:
	print("Unpausing game")  # Debug print
	is_paused = false
	inventory_panel.visible = false
	pause_button.text = "Pausar"
	get_tree().paused = false
