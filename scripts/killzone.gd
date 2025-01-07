extends Area2D

@onready var timer: Timer = $Timer

# When the player colides with this
func _on_body_entered(body: Node2D) -> void:
	print("You died")
	
	Engine.time_scale = 0.5 # Slows down time 
	body.get_node("CollisionShape2D").queue_free() # Removes the Collision from the body that collided (player)
	
	timer.start() # Calls a timer


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	# Restarts the scene
	get_tree().reload_current_scene()
