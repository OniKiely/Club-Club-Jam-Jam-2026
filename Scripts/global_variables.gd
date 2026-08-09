extends Node

#global nodes
var GameController:Node2D
var Particles:Node2D
var Player:CharacterBody2D
var ShellManager:Node2D

#stats
var score: int = 0
var clams: int = 0
var currentLevel:int = 1
var levelTime:float = 0
var totalTime:float = 0


const BUBBLE_TRANSITION = preload("uid://nrx1ltxc82dy")
const BUBBLE_TRANSITION_SFX = preload("uid://dpmehr60v0t4f")

const BEACH_SONG = preload("uid://hvwonjy651b0")

#all levels in an array
var levelArray = [
	"res://Scenes/Levels/level_1.tscn",
	"res://Scenes/Levels/level_2.tscn"
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	_play_music(BEACH_SONG.instantiate())

func _reset_player_data():
	score = 0
	clams = 0
	levelTime = 0
	totalTime = 0

func _play_bubble_transition():
	add_child(BUBBLE_TRANSITION.instantiate())
	_play_sfx(BUBBLE_TRANSITION_SFX.instantiate())
	

func _play_sfx(sfx:Node):
	add_child(sfx)

func _play_music(song:Node):
	add_child(song)

func _next_level():
	if levelArray.size()-1 < currentLevel:
		get_tree().change_scene_to_file("res://Scenes/StartMenu.tscn")
	else:
		get_tree().change_scene_to_file(levelArray[currentLevel])
