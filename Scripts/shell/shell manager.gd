extends Node2D

@export var player: CharacterBody2D

@onready var shellSprite = $ShellSprite

var currentShell:Node = null

func _ready() -> void:
	GlobalVariables.ShellManager = self
	await get_tree().process_frame
	_change_shell(player.shellData)

func _change_shell(shellData:ShellData):
	if currentShell:
		currentShell.queue_free()
	#var newShell = Sprite2D.new()
	shellSprite.texture = shellData.playerShellTexture
	#add_child(newShell)
	#currentShell = newShell
	player.shellData = shellData
