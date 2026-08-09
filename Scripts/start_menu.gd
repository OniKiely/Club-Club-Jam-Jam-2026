extends Node2D

var button_type = null

func _on_start_button_pressed() -> void:
	button_type = "start"
	GlobalVariables._play_bubble_transition()
	
	await get_tree().create_timer(0.7,false).timeout
	
	GlobalVariables._reset_player_data()
	get_tree().change_scene_to_file(GlobalVariables.levelArray[0])


func _on_exit_button_pressed() -> void:
	get_tree().quit()
