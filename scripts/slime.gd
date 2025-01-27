extends Node2D
class_name Slime

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_bottom_left: RayCast2D = $RayCastBottomLeft
@onready var ray_cast_bottom_right: RayCast2D = $RayCastBottomRight

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Verifies if there is a wall on the direction
	if ray_cast_right.is_colliding() or !ray_cast_bottom_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true # Flips the animation left right
	if ray_cast_left.is_colliding() or !ray_cast_bottom_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false # Flips the animation left right
	
	position.x += direction * SPEED * delta
