@tool
extends Area2D
class_name score_pickup

@onready var sprite: AnimatedSprite2D = $sprite

@export var data: score_item_data
@export var animation_player:AnimationPlayer

@export var soundFX:PackedScene

func _ready():
	$Sprite2D.texture = data.sprite

# when player picks up power up
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GlobalVariables.score += data.score_value
		GlobalVariables.clams += data.clam_value
		GlobalVariables._play_sfx(soundFX.instantiate())
		#print("Points: ", GlobalVariables.score)
		if animation_player:
			animation_player.play("collect")
			sprite.play("spin")
			await get_tree().physics_frame
			$CollisionShape2D.disabled = true
			await get_tree().create_timer(1,false).timeout
			queue_free()
		else:
			queue_free()
		
	
