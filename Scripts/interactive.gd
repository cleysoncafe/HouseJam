extends Node3D

# Reference to the label that will display messages
@onready var interaction_label = get_node("CanvasLayer/Interaction")

# Distance for interaction
@export var interaction_range: float = 5.0

# List of interactive objects in the scene
var interactive_objects: Array = []

func _ready():
	# Ensure the interaction label is initially hidden
	if interaction_label:
		interaction_label.visible = false
	else:
		# If the interaction_label is not found, log an error and return
		printerr("Interaction label node not found!")
		return

func _physics_process(delta):
	# Check for nearby interactive objects
	check_interactions()

func check_interactions():
	# Find the closest interactive object
	var closest_object = find_closest_interactive_object()
	
	# Handle interaction input
	if closest_object and Input.is_action_just_pressed("interact"):
		interact_with_object(closest_object)

func find_closest_interactive_object():
	var closest_object = null
	var min_distance = interaction_range
	
	for obj in interactive_objects:
		var distance = global_position.distance_to(obj.global_position)
		if distance < min_distance:
			closest_object = obj
			min_distance = distance
	
	return closest_object

func interact_with_object(object):
	# Check if the object has an interaction message
	if object.has_method("get_interaction_message"):
		var message = object.get_interaction_message()
		display_interaction_message(message)

func display_interaction_message(message: String):
	# Show the interaction message
	if interaction_label:
		interaction_label.text = message
		interaction_label.visible = true
		
		# Use Godot 4.x timer method
		var timer = get_tree().create_timer(3.0)
		timer.timeout.connect(func(): interaction_label.visible = false)
	else:
		printerr("Interaction label node not found!")
