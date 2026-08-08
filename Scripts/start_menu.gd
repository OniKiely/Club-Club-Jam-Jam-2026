extends Control

var button_type = null

func _on_start_button_pressed() -> void:
	button_type = "start"
	$ColorRect/AnimationPlayer.play_backwards("fade in")
	
	await get_tree().create_timer(1.1,false).timeout
	
	get_tree().change_scene_to_file("res://Scenes/testWorld.tscn")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
