extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# When the player colides with this
	print("You died")
	timer.start() # Calls a timer


func _on_timer_timeout() -> void:
	# Restarts the scene
	get_tree().reload_current_scene()
