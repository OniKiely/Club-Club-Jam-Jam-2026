extends Node2D

const P_START_MENU = preload("res://Scenes/StartMenu.tscn")
const P_TEST_WORLD = preload("res://Scenes/testWin.tscn")



@onready var scene_holder: Node2D = $"Scene Holder"

var currentScene:Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentScene = $"Scene Holder/StartMenu"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalVariables.GameController = self

func _play():
	currentScene.queue_free()
	#var Packed_level:PackedScene = load(P_TEST_WORLD_path)
	var level = P_TEST_WORLD.instantiate()
	currentScene = level
	scene_holder.add_child(level)

func _return_to_menu():
	currentScene.queue_free()
	var mainMenu = P_START_MENU.instantiate()
	currentScene = mainMenu
	scene_holder.add_child(mainMenu)
	

func _play_bubble_transition():
	const BUBBLE_TRANSITION = preload("uid://nrx1ltxc82dy")
	$transition.add_child(BUBBLE_TRANSITION.instantiate())
	
