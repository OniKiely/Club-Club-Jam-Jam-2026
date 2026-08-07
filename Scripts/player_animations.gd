extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var Player:CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_reanimate()
	
	


func _reanimate():
	if Player.grounded:
		if Player.walking:
			_play_animation("walking")
		else:
			_play_animation("idle")
	else:
		if Player.velocity.y > 0:
			_play_animation("falling")
		else:
			_play_animation("jumping")


func _play_animation(animation:String):
	if animation_player.current_animation == animation:
		return
	animation_player.play(animation)
