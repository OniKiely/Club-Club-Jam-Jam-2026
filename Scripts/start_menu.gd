extends Control

var button_type = null

func _on_start_button_pressed() -> void:
	button_type = "start"
	$fade_transition.visible = true
	$fade_transition/fade_timer.start()
	$fade_transition/AnimationPlayer.play("fade_in")


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://Scenes/shootingTest.tscn")
