extends Area2D
signal hitCamera

@onready var timer: Timer = $Timer

# When the player colides with this
func _on_body_entered(body: Node2D) -> void:
	hitCamera.emit()
	Global.MainCamera2D.apply_shake()
	
	# If the player is rolling, kill the parent instead of the player
	if get_parent() is Slime:
		if (Global.player and Global.player.current_state == Global.player.states.ROLL):
				print("you killed the mob")
				get_parent().queue_free()
		else: 
			die(body)
	else: 
		die(body)

func die(body: Node2D):
		print("You died")
		Engine.time_scale = 0.5 # Slows down time 
		body.get_node("CollisionShape2D").queue_free() # Removes the Collision from the body that collided (player)
		timer.start() # Calls a timer


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	# Restarts the scene
	get_tree().reload_current_scene()
