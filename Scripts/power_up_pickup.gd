@tool
extends Area2D
class_name power_up_pickup

@export var data: power_up_data

func _ready():
	$Sprite2D.texture = data.sprite

# when player picks up power up
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.collect_powerup(data.name)
		queue_free()
