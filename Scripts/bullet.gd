extends Area2D

@export var speed := 800.0
@export var lifespan:float = 3
var velocity:Vector2

var direction: Vector2 = Vector2.ZERO

func _ready():
	rotation = direction.angle()
	await get_tree().process_frame
	velocity = direction * speed
	
	await get_tree().create_timer(lifespan,false).timeout
	queue_free()

func _physics_process(delta):
	global_position += direction * speed * delta
