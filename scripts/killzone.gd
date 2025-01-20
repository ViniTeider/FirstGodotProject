extends Area2D

@onready var timer: Timer = $Timer
@onready var die_sound: AudioStreamPlayer2D = $"../DieSound"

# When the player colides with this
func _on_body_entered(body: Node2D) -> void:
	# If the player is rolling, kill the parent instead of the player
	if get_parent() is Slime:
		# Makes the camera shake
		get_tree().call_group("Player","apply_shake")
		play_hurt_sound(die_sound)
		if (Global.player and Global.player.current_state == Global.player.states.ROLL):
			get_parent().queue_free()
		else: 
			kill_player(body)
	else:
		kill_player(body)

func kill_player(body: Node2D):
		Engine.time_scale = 0.5 # Slows down time 
		body.get_node("CollisionShape2D").queue_free() # Removes the Collision from the body that collided (player)
		timer.start() # Calls a timer

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene() # Restarts the scene


func play_hurt_sound(audio_player: AudioStreamPlayer2D):
	# The audio is not playing for some reason, not sure why :T
	print("here")
	if audio_player.playing == false:
		audio_player.play()
