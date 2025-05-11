extends Area3D

# Customizable interaction message
@export var interaction_text: String = "Interact with me!"

func get_interaction_message() -> String:
	return interaction_text

func _ready():
	# Updated signal connection method for Godot 4.x
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

# Use named functions for signal connections
func _on_body_entered(body):
	if body.has_method("register_interactive_object"):
		body.register_interactive_object(self)

func _on_body_exited(body):
	if body.has_method("unregister_interactive_object"):
		body.unregister_interactive_object(self)
