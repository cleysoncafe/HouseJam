extends CharacterBody3D

@onready var anim_player = $Visuals/mixamo_base/AnimationPlayer
@onready var visuals = $Visuals

const SPEED = 2.4
const JUMP_VELOCITY = 4.5 
var walking_speed = 2.4
var running_speed = 4.0
var running = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var last_movement = Vector3.ZERO
var current_camera: Camera3D = null

func _physics_process(delta):
	get_current_camera()
	handle_movement(delta)
	move_and_slide()

func get_current_camera():
	var cameras = get_tree().get_nodes_in_group("cameras")
	current_camera = null
	for cam in cameras:
		if cam.current:
			current_camera = cam
			break
	if not current_camera:
		current_camera = get_viewport().get_camera_3d()

func handle_movement(delta):
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		running = true
	else:
		SPEED = walking_speed
		running = false

	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("turn_left", "turn_right", "move_fowards", "move_backwards")
	if input_dir != Vector2.ZERO and current_camera:
		var cam_basis = current_camera.global_transform.basis
		var direction = (cam_basis.x * input_dir.x + cam_basis.z * input_dir.y).normalized()
		last_movement = direction
		play_animation(running)
		visuals.look_at(position + direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		play_animation("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func play_animation(state):
	if anim_player.current_animation != state:
		anim_player.play(state)
