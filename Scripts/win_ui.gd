extends Control

var levelScore := 0
@export var score_label: Label


@onready var win_flag = $"../../winFlag"
@onready var pause_menu = $"../../PauseCL/PauseMenu"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	win_flag.level_won.connect(_on_level_won)

func _on_level_won():
	#May change this later
	levelScore = GlobalVariables.score
	GlobalVariables.totalTime += GlobalVariables.levelTime
	
	score_label.text = "Score: " + str(levelScore)
	
	#Lock the pause menu
	pause_menu.set_pause_locked(true)
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("blur")
	$UI/AnimationPlayer.play("wave")


func _on_next_button_pressed() -> void:
	get_tree().paused = false
	GlobalVariables._next_level()


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
