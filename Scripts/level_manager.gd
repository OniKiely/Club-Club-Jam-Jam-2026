extends Node2D

@export var initial_camera_limiter: CameraLimiter
@export var player: CharacterBody2D
#@export var particlesHolder:Node2D

@export var Level:int = 1


func _ready():
	GlobalVariables.levelTime = 0
	# sets up starting camera bounds
	if initial_camera_limiter and player:
		player.camera.camera_limit_manager.set_limiter(initial_camera_limiter, true)
		#print("hello")
	
	GlobalVariables.currentLevel = Level
	#await get_tree().process_frame
	#GlobalVariables.Particles = particlesHolder
	#print(particlesHolder,"particl")

func _process(delta: float) -> void:
	GlobalVariables.levelTime += delta
