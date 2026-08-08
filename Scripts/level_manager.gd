extends Node2D

@export var initial_camera_limiter: CameraLimiter
@export var player: CharacterBody2D

func _ready():
	# sets up starting camera bounds
	if initial_camera_limiter and player:
		player.camera.camera_limit_manager.set_limiter(initial_camera_limiter, true)
		print("hello")
