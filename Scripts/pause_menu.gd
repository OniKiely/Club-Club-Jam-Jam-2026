extends Control

var pause_locked := false

func _ready() -> void:
	get_tree().paused = false
	visible = false
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	
	if GlobalVariables.Player.current_state == GlobalVariables.Player.state.DEATH:
		return
		
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("blur")

func testPause():
	if pause_locked:
		return
		
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()


func _on_resume_button_pressed() -> void:
	resume()


func _on_restart_button_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	GlobalVariables._play_bubble_transition()
	await get_tree().create_timer(0.7,false).timeout
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _process(_delta):
	testPause()

func set_pause_locked(locked: bool):
	pause_locked = locked
