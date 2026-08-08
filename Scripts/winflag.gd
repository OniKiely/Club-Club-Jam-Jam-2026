extends Area2D

signal level_won

var triggered: bool = false

func _on_body_entered(body: Node2D) -> void:
	if triggered: return
	
	if body.is_in_group("Player"):
		triggered = true
		level_won.emit()
