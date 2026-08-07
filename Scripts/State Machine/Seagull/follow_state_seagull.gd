extends state

#calls once when the state is switched to
func enter() -> void:
	pass

#called each frame, but only when the state is active
func run(delta: float) -> void:
	pass

#called when the state is switched out of
func exit() -> void:
	pass
