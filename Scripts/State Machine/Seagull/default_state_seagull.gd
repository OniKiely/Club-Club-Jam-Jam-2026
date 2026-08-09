extends state

var dir = Vector2(1, 0)
var speed = 50

#calls once when the state is switched to
func enter() -> void:
	$FlipTimer.start()
	get_parent().get_parent().velocity = dir * speed

#called each frame, but only when the state is active
func run(delta: float) -> void:
	pass #main seagull already does move_and_slide()

#called when the state is switched out of
func exit() -> void:
	$FlipTimer.stop()

func _on_flip_timer_timeout() -> void:
	dir.x *= -1
	get_parent().get_parent().velocity = dir * speed
