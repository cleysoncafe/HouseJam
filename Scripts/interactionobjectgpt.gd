extends Node3D

@export var interaction_text: String = "You interacted with the object!"
var is_player_nearby: bool = false

# Nodes
@onready var label: Label3D = $Label3D

func _ready():
	var label_node = $Label3D  # Or get_node("Label3D")
	if label_node == null:
		print("Label3D not found!")
	else:
		print("Label3D found successfully.")
		label_node.visible = false  # Hide the label by default

func _on_area_entered(body):
	if body.name == "Player":  # Adjust based on your player node's name
		is_player_nearby = true

func _on_area_exited(body):
	if body.name == "Player":
		is_player_nearby = false
		label.visible = false  # Ensure the label hides when the player leaves

func _process(delta):
	if is_player_nearby and Input.is_action_just_pressed("interact"):
		show_interaction()

func show_interaction():
	label.visible = true  # Show the label only when interacting
	print("Interaction triggered with", self.name)
	perform_interaction()

func perform_interaction():
	# Replace this with your specific interaction logic
	print("Performing interaction with", self.name)
	
