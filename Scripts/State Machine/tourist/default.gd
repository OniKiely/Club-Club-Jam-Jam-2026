extends state

func enter() -> void:
	pass

func run(delta) -> void:
	pass

func exit() -> void:
	pass


func _on_detection_area_body_entered(body: Node2D) -> void:
	get_parent().switch_to("Follow")
