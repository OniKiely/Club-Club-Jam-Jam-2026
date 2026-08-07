extends CharacterBody2D

@export var deathUI: Control

@onready var sprite = $sprite
@onready var camera = $Camera2D

@export var attack_cooldown:float = 0
var T_attack_cooldown:float = 0

var speed: int = 250
var acceleration: int = 700
var friction = 900
var jump_strength = -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_checkpoint: Vector2

var current_state = state.DEFAULT
enum state {
	DEFAULT,
	DEATH
}

var walking:bool = false
var grounded:bool = false

func _ready():
	GlobalVariables.Player = self
	print("Aim:", aim)
	print("Bullet Scene:", bullet_scene)
	
	# set starting checkpoint
	current_checkpoint = global_position

func _physics_process(delta: float) -> void:
	match current_state:
		state.DEFAULT:
			apply_gravity(delta)
			handle_jump()
			movement(delta)
		state.DEATH:
			sprite.visible = false
	
		
	
	# FOR TESTING ONLY REMOVE BEFORE RELEASE
	if Input.is_action_just_pressed("kill_button"):
		on_death()

func movement(delta):
	# move left and right
	var input_axis = Input.get_axis("move_left", "move_right")
	if input_axis != 0:
		sprite.scale.x = input_axis
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)
		walking = true
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		walking = false
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		grounded = false
		velocity.y += gravity * delta
	else:
		grounded = true

func handle_jump():
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_strength
	else:
		if Input.is_action_just_released("jump") and velocity.y < jump_strength / 2:
			velocity.y = jump_strength / 2

# this is where we write what happens depending on which power up is collected
# gets called in power_up_pickup
func collect_powerup(name):
	match name:
		"example":
			pass
		_:
			print("Unknown powerup collected. ", name, " not valid")

func on_death():
	camera.apply_shake(15)
	current_state = state.DEATH
	Engine.time_scale = 0.5
	await get_tree().create_timer(2).timeout
	Engine.time_scale = 0
	if deathUI:
		deathUI.show()

func respawn():
	self.global_position = current_checkpoint

#bullet code
@export var bullet_scene: PackedScene
@onready var aim = $Aim
@onready var weapon = $Weapon

func _process(delta: float):
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	weapon.rotation = direction.angle()
	
	
	if T_attack_cooldown != 0:
		T_attack_cooldown = move_toward(T_attack_cooldown,0,delta)

func _input(event):
	if event.is_action_pressed("shoot") and T_attack_cooldown == 0:
		shoot()
		T_attack_cooldown = attack_cooldown

func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = aim.global_position
	bullet.direction = (get_global_mouse_position() - aim.global_position).normalized()
