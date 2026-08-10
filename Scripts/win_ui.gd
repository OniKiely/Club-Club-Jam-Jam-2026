extends Control

@export var score_label: Label
@export var time_label: Label
@export var total_time_label: Label

const WIN_SFX = preload("uid://dps0hvuhfapx")


@onready var win_flag = $"../../winFlag"
@onready var pause_menu = $"../../PauseCL/PauseMenu"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	win_flag.level_won.connect(_on_level_won)

func _on_level_won():
	#May change this later
	
	GlobalVariables.totalTime += GlobalVariables.levelTime
	
	score_label.text = "Score: " + str(GlobalVariables.score)
	time_label.text = "Time: " + str(snapped(GlobalVariables.levelTime,0.01))
	total_time_label.text = "Total Time: " + str(snapped(GlobalVariables.totalTime,0.01))
	
	
	GlobalVariables._play_sfx(WIN_SFX.instantiate())
	
	#Lock the pause menu
	pause_menu.set_pause_locked(true)
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("blur")
	$UI/AnimationPlayer.play("wave")


func _on_next_button_pressed() -> void:
	GlobalVariables._play_bubble_transition()
	
	await get_tree().create_timer(0.7).timeout
	get_tree().paused = false
	GlobalVariables._next_level()


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
