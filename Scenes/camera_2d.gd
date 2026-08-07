extends Camera2D

@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var current_shake_strength: float = 0.0

func apply_shake(shake_strength: int):
	current_shake_strength = shake_strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_shake_strength > 0:
		current_shake_strength = lerpf(current_shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()

func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-current_shake_strength,current_shake_strength),
	rng.randf_range(-current_shake_strength,current_shake_strength))
