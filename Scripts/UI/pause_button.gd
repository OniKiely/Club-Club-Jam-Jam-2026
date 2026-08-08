extends Control

@export var pauseMenu:Node

func _on_button_pressed() -> void:
	pauseMenu.pause()
