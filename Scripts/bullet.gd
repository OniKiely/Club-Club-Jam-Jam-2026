extends Area2D

@export var speed := 800.0
@export var lifespan:float = 3
var velocity:Vector2

var direction: Vector2 = Vector2.ZERO

var sfxPlayed:bool = false

const BUBBLE_POP_SFX = preload("uid://ftm38eclpp1v")



func _ready():
	rotation = direction.angle()
	await get_tree().process_frame
	velocity = direction * speed
	
	await get_tree().create_timer(lifespan,false).timeout
	queue_free()

func _physics_process(delta):
	global_position += direction * speed * delta

#called when the bullet hits an enemy
#deletes projectile when the particles are done emitting
func delete():
	$"particle emmiter".emitting = false
	var direction = Vector2.ZERO
	$Sprite2D.hide()
	
	if !sfxPlayed:
		GlobalVariables._play_sfx(BUBBLE_POP_SFX.instantiate())
	
	await get_tree().create_timer(0.5).timeout
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if !sfxPlayed:
		GlobalVariables._play_sfx(BUBBLE_POP_SFX.instantiate())
	queue_free()
