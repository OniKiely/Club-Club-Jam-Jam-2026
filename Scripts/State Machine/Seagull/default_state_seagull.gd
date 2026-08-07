extends state

#calls once when the state is switched to
func enter() -> void:
	print("entered")

#called each frame, but only when the state is active
func run(delta: float) -> void:
	print("running")

#called when the state is switched out of
func exit() -> void:
	print("exited")
