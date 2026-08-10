extends Node

#global nodes
var GameController:Node2D
var Particles:Node2D
var Player:CharacterBody2D
var ShellManager:Node2D

#stats
var score: int = 0
var clams: int = 0
var tempScore: int = 0
var tempClams: int = 0
var currentLevel:int = 1
var levelTime:float = 0
var totalTime:float = 0

var muted = false
var volume = 0

const BUBBLE_TRANSITION = preload("uid://nrx1ltxc82dy")
const BUBBLE_TRANSITION_SFX = preload("uid://dpmehr60v0t4f")

var Songs:Dictionary = {
	"beach" = "res://Scenes/SFX/music/beach_song.tscn",
	"final" = "res://Scenes/SFX/music/final_song.tscn",
	"ocean" = "res://Scenes/SFX/music/ocean_song.tscn",
	"credits" = "res://Scenes/SFX/music/credits_song.tscn",
}

const BEACH_SONG = preload("uid://hvwonjy651b0")


var current_music:String = ""
var current_music_node:Node

#all levels in an array
var levelArray = [
	"res://Scenes/Levels/level_1.tscn",
	"res://Scenes/Levels/level_2.tscn",
	"res://Scenes/Levels/level_3.tscn",
	"res://Scenes/Levels/level_swaggy.tscn",
	"res://Scenes/Levels/random_Level.tscn",
	"res://Scenes/Levels/last level.tscn"
]

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	_play_music("beach")

func _reset_player_data():
	score = 0
	clams = 0
	levelTime = 0
	totalTime = 0

func _reset_level_data():
	score = tempScore
	clams = tempClams

func _play_bubble_transition():
	add_child(BUBBLE_TRANSITION.instantiate())
	_play_sfx(BUBBLE_TRANSITION_SFX.instantiate())
	

func _play_sfx(sfx:Node):
	add_child(sfx)

func _play_music(song:String):
	if song == "none":
		current_music_node.queue_free()
		return
	if current_music == song:
		return
	if Songs.has(song):
		var newsong = load(Songs[song]).instantiate()
		add_child(newsong)
		current_music = song
		
		if current_music_node:
			current_music_node.queue_free()
		
		current_music_node = newsong

func _next_level():
	if levelArray.size()-1 < currentLevel:
		get_tree().change_scene_to_file("res://Scenes/end_scene.tscn")
	else:
		get_tree().change_scene_to_file(levelArray[currentLevel])
		GlobalVariables.tempClams = GlobalVariables.clams
		GlobalVariables.tempScore = GlobalVariables.score
