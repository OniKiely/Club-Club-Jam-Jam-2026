extends state

func enter() -> void:
	get_parent().get_parent().attack()
	await get_tree().create_timer(3).timeout
	get_parent().switch_to("Follow")


func run(delta) -> void:
	pass

func exit() -> void:
	pass
