extends Control

var pause_locked := false
var textures = [preload("uid://voa307ji63k"), preload("uid://c4ua5y522adju")]

func _ready() -> void:
	print(str(AudioServer.get_bus_volume_db(0)))
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
	GlobalVariables._play_bubble_transition()
	await get_tree().create_timer(0.7).timeout
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")

func _process(_delta):
	testPause()

func set_pause_locked(locked: bool):
	pause_locked = locked


func _on_texture_button_pressed() -> void:
	GlobalVariables.muted = !GlobalVariables.muted
	if GlobalVariables.muted:
		$TextureButton.texture_normal = textures[1]
	else:
		$TextureButton.texture_normal = textures[0]
	AudioServer.set_bus_mute(0, GlobalVariables.muted)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)
