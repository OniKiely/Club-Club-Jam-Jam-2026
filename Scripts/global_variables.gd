extends Node

#global nodes
var GameController:Node2D
var Particles:Node2D
var Player:CharacterBody2D
var ShellManager:Node2D

var score: int = 0
var clams: int = 0



const BUBBLE_TRANSITION = preload("uid://nrx1ltxc82dy")
const BUBBLE_TRANSITION_SFX = preload("uid://dpmehr60v0t4f")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _play_bubble_transition():
	add_child(BUBBLE_TRANSITION.instantiate())
	_play_sfx(BUBBLE_TRANSITION_SFX.instantiate())
	

func _play_sfx(sfx:Node):
	add_child(sfx)
