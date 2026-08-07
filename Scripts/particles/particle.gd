extends Node2D

@export var initialVelocity:Vector2 = Vector2(0,0)
@export var initialVelocityRandomness:Vector2 = Vector2(0,0)
@export var gravity:Vector2 = Vector2(0,9.8)
@export var hasDrag:bool = false

@export var initialRotationalVelocity:float = 0
@export var initialRotationalVelocityRandomness:float = 0

@export var randomSprite:bool = true
@export var spritesHolder:Node
@export var spritesAmount:int

@export var liveForever:bool = false
@export var lifespan:float = 0.5
@export var lifespanRandomness:float = 0
@export var fadeAnimationPlayer:AnimationPlayer  

var particleVelocity:Vector2 = Vector2(0,0)
var particleRotationalVelocity:float = 0


func _ready() -> void:
	if randomSprite:
		var randSprite = randi_range(0,spritesAmount-1)
		spritesHolder.get_child(randSprite).visible = true
		
		for sprite in spritesHolder.get_children():
			if !sprite.visible:
				sprite.queue_free()
		#
	
	initialVelocity.x += randf_range(-initialVelocityRandomness.x,initialVelocityRandomness.x)
	initialVelocity.y += randf_range(-initialVelocityRandomness.y,initialVelocityRandomness.y)
	particleVelocity = initialVelocity
	
	initialRotationalVelocity += randf_range(-initialRotationalVelocityRandomness,initialRotationalVelocityRandomness)
	particleRotationalVelocity = initialRotationalVelocity
	
	lifespan += randf_range(-lifespanRandomness,lifespanRandomness)
	if !liveForever:
		await get_tree().create_timer(lifespan,false).timeout
		if fadeAnimationPlayer:
			fadeAnimationPlayer.play("fade out")
		else:
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	particleVelocity += gravity
	
	position += particleVelocity * delta
	rotation += particleRotationalVelocity*delta
	
	if hasDrag:
		particleVelocity = lerp(particleVelocity,Vector2(0,0),delta)
		particleRotationalVelocity = lerp(particleRotationalVelocity,0.0,delta)
