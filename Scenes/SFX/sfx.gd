extends AudioStreamPlayer

@export var randomizePitch:bool = true
@export var randomizedPitch:Vector2 = Vector2(0.8,1.2)

func  _ready() -> void:
	if randomizePitch:
		pitch_scale = randf_range(randomizedPitch.x,randomizedPitch.y)

func _on_finished() -> void:
	queue_free()
