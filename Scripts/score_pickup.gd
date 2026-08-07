@tool
extends Area2D
class_name score_pickup

@export var data: score_item_data

func _ready():
	$Sprite2D.texture = data.sprite

# when player picks up power up
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalVariables.score += data.score_value
		GlobalVariables.clams += data.clam_value
		print("Points: ", GlobalVariables.score)
		queue_free()
