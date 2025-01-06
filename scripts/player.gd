extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var jump_number = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_pressed("ui_accept") and jump_number < 1:
			velocity.y = JUMP_VELOCITY
			jump_number += 1
		else:
			velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_number += 1
		
	# Resets double jump
	if is_on_floor():
		jump_number = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
