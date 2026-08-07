extends Area2D

@export var speed := 800.0
var velocity:Vector2

var direction: Vector2 = Vector2.ZERO

func _ready():
	rotation = direction.angle()
	await get_tree().process_frame
	velocity = direction * speed

func _physics_process(delta):
	global_position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	queue_free()
