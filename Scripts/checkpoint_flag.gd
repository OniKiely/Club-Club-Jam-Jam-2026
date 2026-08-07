extends Area2D

var is_used: bool = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and is_used == false:
		body.current_checkpoint = global_position
		$Sprite2D.frame = 1
		is_used = true
