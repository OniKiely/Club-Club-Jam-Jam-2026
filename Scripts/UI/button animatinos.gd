extends Button

@export var animationPlayer:AnimationPlayer



func _on_mouse_entered() -> void:
	animationPlayer.play("enter")


func _on_mouse_exited() -> void:
	animationPlayer.play_backwards("enter")
