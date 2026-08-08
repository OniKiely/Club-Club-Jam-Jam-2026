@tool
extends Node2D

@export var shell:ShellData
@onready var sprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = shell.pickupTexture


func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVariables.ShellManager._change_shell(shell)
	queue_free()
