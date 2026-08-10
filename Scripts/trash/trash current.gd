extends CharacterBody2D

@export var chargeFrequency:float = 3
@export var chargeRandomness:float = 1
var charging:bool = false
var T_chargeTimer:float = chargeFrequency

var playerXDirection

var trashVelocity:Vector2 = Vector2(0,0)
var acceleration:Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	trashVelocity += acceleration
	
	if GlobalVariables.Player.position.x > position.x:
		playerXDirection = 1
	else:
		playerXDirection = -1
	
	_trash_physics(delta)
	
	if T_chargeTimer != 0:
		T_chargeTimer = move_toward(T_chargeTimer,0,delta)
		if T_chargeTimer == 0:
			#_charge()
			T_chargeTimer = chargeFrequency + randf_range(-chargeRandomness,chargeRandomness)
	
	

func _charge():
	print("CHARGE")
	acceleration.x = playerXDirection * 3
	trashVelocity.y = 0
	acceleration.y = -1
	charging = true
	await get_tree().create_timer(0.3,false).timeout
	acceleration.y = -3
	await get_tree().create_timer(0.2,false).timeout
	acceleration = Vector2(0,1)
	charging = false

@onready var down_ray: RayCast2D = $"down ray"
@onready var left_ray: RayCast2D = $"left ray"
@onready var right_ray: RayCast2D = $"right ray"


func _trash_physics(delta):
	down_ray.rotation = -rotation
	left_ray.rotation = -rotation
	right_ray.rotation = -rotation
	#if !charging:
		#if down_ray.is_colliding():
			#acceleration.y = move_toward(acceleration.y,-1,delta*5)
			#if trashVelocity.y > 0:
				#trashVelocity.y = move_toward(trashVelocity.y,0.0,delta*500)
		#else:
			#acceleration.y = move_toward(acceleration.y,1,delta/10)
		#if left_ray.is_colliding():
			#acceleration.x = move_toward(acceleration.x,5,delta*20)
		#if right_ray.is_colliding():
			#acceleration.x = move_toward(acceleration.x,-5,delta*20)
			#
		#
		#trashVelocity.x = lerp(trashVelocity.x,0.0,delta)
	
	
	position += trashVelocity
	move_and_slide()
