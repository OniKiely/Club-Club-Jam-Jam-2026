extends Button

@export var animationPlayer:AnimationPlayer

@export var playSFX:bool = true

const MENU_BUTTON_SFX = preload("res://Scenes/SFX/menu_button_sfx.tscn")


func _on_mouse_entered() -> void:
	animationPlayer.play("enter")


func _on_mouse_exited() -> void:
	animationPlayer.play_backwards("enter")

func _on_pressed():
	if playSFX:
		GlobalVariables._play_sfx(MENU_BUTTON_SFX.instantiate())
