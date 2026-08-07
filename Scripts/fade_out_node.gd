extends Node

@onready var fade_transition = $"../CanvasLayer/fade_transition/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_transition.play("fade_out")
