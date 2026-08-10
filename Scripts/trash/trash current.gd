extends CharacterBody2D

@export var score:int = 100

@export var chargeFrequency:float = 4
@export var chargeRandomness:float = 1
var charging:bool = false
var T_chargeTimer:float = chargeFrequency

var playerXDirection

var acceleration:Vector2 = Vector2(0,0)


var playerChargePercent:float = 0
var chargeTowardsPlayer:bool

var active:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	velocity += acceleration
	
	if GlobalVariables.Player.position.x > position.x:
		playerXDirection = 1
	else:
		playerXDirection = -1
	
	_trash_physics(delta)
	
	if chargeTowardsPlayer or charging:
		$"particle emmiter2".emitting = true
		rotation += delta * 4
	else:
		rotation += delta * -2
		$"particle emmiter2".emitting = false
		
	
	if chargeTowardsPlayer:
		rotation += delta * 2
		var Cvelocity = (position - GlobalVariables.Player.position).normalized() * Vector2(-2,-2)
		
		if playerChargePercent < 0.8:
			velocity = lerp(velocity,Cvelocity,delta * playerChargePercent * 50)
			playerChargePercent += delta * 2
		if playerChargePercent > 0.5:
			chargeTowardsPlayer = false
	
	if T_chargeTimer != 0:
		T_chargeTimer = move_toward(T_chargeTimer,0,delta)
		if T_chargeTimer == 0:
			if active:
				_charge()
			T_chargeTimer = chargeFrequency + randf_range(-chargeRandomness,chargeRandomness)
	
	

func _charge():
	acceleration.x = playerXDirection * 0.03
	velocity.y = 0
	acceleration.y += -0.005
	charging = true
	await get_tree().create_timer(0.3,false).timeout
	acceleration.x = 0
	acceleration.y += -0.04
	await get_tree().create_timer(0.2,false).timeout
	acceleration = Vector2(0,0)
	charging = false
	
	_charge_toward_player()

@onready var down_ray: RayCast2D = $"down ray"
@onready var left_ray: RayCast2D = $"left ray"
@onready var right_ray: RayCast2D = $"right ray"

func _charge_toward_player():
	playerChargePercent = 0
	chargeTowardsPlayer = true
	acceleration = Vector2(0,0)
	#velocity = (position - GlobalVariables.Player.position).normalized() * Vector2(-2,-2)
	await get_tree().create_timer(1,false).timeout
	chargeTowardsPlayer = false

func _trash_physics(delta):
	down_ray.rotation = -rotation
	left_ray.rotation = -rotation
	right_ray.rotation = -rotation
	if !charging and !chargeTowardsPlayer:
		if down_ray.is_colliding():
			acceleration.y = move_toward(acceleration.y,-0.02,delta/5)
			if velocity.y > 0:
				velocity.y = move_toward(velocity.y,0.0,delta*5)
		else:
			acceleration.y = move_toward(acceleration.y,0.01,delta)
		if left_ray.is_colliding():
			acceleration.x = move_toward(acceleration.x,0.01,delta)
		if right_ray.is_colliding():
			acceleration.x = move_toward(acceleration.x,-0.01,delta)
			
		
		velocity.x = lerp(velocity.x,0.0,delta)
	
	position += velocity
	move_and_slide()




func _on_hurtbox_area_entered(area: Area2D) -> void:
	GlobalVariables.score += score
	area.delete()
	await get_tree().process_frame
	await get_tree().physics_frame
	queue_free()


func _on_activate_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		active = true
		


func _on_activate_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		active = false
