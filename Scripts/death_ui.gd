extends Control

@onready var player = $"../../Player"
@onready var fact_label = $FactLabel
@onready var pause_menu = $"../../PauseCL/PauseMenu"

var facts: Array[String] = [
	"Insert fact here",
	"insert more here"
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	player.gameOver.connect(_gameOver)

func _gameOver() -> void:
	fact_label.text = facts.pick_random()
	
	pause_menu.set_pause_locked(true)
	get_tree().paused = true
	visible = true
	$AnimationPlayer.play("fade")

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")


func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
