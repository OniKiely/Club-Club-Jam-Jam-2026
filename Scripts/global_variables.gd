extends Node

#global nodes
var GameController:Node2D
var Particles:Node2D
var Player:CharacterBody2D
var ShellManager:Node2D

var score: int = 0
var clams: int = 0


func _play_bubble_transition():
	const BUBBLE_TRANSITION = preload("uid://nrx1ltxc82dy")
	add_child(BUBBLE_TRANSITION.instantiate())
	
	
