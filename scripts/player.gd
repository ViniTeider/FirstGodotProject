extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var roll_timer: Timer = $Roll_timer


enum states {
	MOVE,
	ROLL
}


const SPEED = 130.0
const ROLL_SPEED = 200
const JUMP_VELOCITY = -300.0

var current_state = states.MOVE
var jump_number = 0


func _input(event: InputEvent) -> void:
	# Checks if the player state is MOVE, in order to be able to roll
	if current_state == states.MOVE:
		if event.is_action_pressed("roll"):
			# Sets the current state to ROLL
			current_state = states.ROLL
			roll_timer.start()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_just_pressed("jump") and jump_number < 1:
			velocity.y = JUMP_VELOCITY
			jump_number += 1
		else:
			velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_number += 1
		
	# Resets double jump
	if is_on_floor():
		jump_number = 0

	# Gets the input direction (-1, 0, 1)
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	# Play animations
	if current_state == states.ROLL:
			animated_sprite.play("roll")
	elif current_state == states.MOVE:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
	
	# Aply the movement
	if direction:
		if current_state == states.MOVE:
			velocity.x = direction * SPEED
		elif current_state == states.ROLL:
			velocity.x = direction * ROLL_SPEED 	# If rolling, use roll speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

# When rolling ends
func _on_timer_timeout() -> void:
	current_state = states.MOVE
