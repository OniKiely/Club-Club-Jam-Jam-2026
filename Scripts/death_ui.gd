extends Control

@onready var player = $"../../Player"
@onready var fact_label = $FactLabel
@onready var pause_menu = $"../../PauseCL/PauseMenu"

var facts: Array[String] = [
	"More than 560,000 hermit crabs were killed by plastic debris 
	on two remote islands. (McCauley et al., 2019)",
	"36% of blue crabs sampled in Corpus Christi Bay were found 
	to have plastic particles in their stomachs. (Phillips & Bonner, 2020)",
	"Invasive yellow crazy ants have killed tens of millions 
	of Christmas Island red crabs. (Parks Australia)",
	"Only 1.8% of beach debris recorded on Christmas Island 
	originated from the island or mainland Australia. 
	(Marine Pollution Bulletin, 2026)",
	"Ocean acidification caused 100% mortality in juvenile 
	red king crabs after 95 days at pH 7.5. (Long et al., 2013)",
	"Fiddler crabs in a polluted Colombian mangrove accumulated 
	microplastics at approximately 13 times the concentration 
	found in surrounding sediment. (Global Change Biology, 2025)"
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
