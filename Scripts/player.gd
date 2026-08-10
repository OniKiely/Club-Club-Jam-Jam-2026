extends CharacterBody2D

@export var deathUI: Control

@onready var sprite = $sprite
@onready var camera = $Camera2D
@onready var powerup_abilites = $Powerups

#@export var shellManager: Node2D
@export var shellData:ShellData

var T_attack_cooldown:float = 0

var lives = 3
signal gameOver()

var default_speed: int = 250
var current_speed: int = default_speed
var acceleration: int = 700
var friction = 900
var jump_strength = -400
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_jump: bool = true

var current_checkpoint: Vector2

var heart_textures = [preload("uid://du2lbh0gw7ty0"), preload("uid://cif88dr5q1eno")]

const GUN_SFX = preload("uid://c646ltlf38wv4")

var current_state = state.DEFAULT
enum state {
	DEFAULT,
	DEATH,
	DASH,
}

var current_powerup = powerup.NONE
enum powerup {
	NONE,
	FASTFALL,
	DASH,
}

var walking:bool = false
var grounded:bool = false

func _ready():
	GlobalVariables.Player = self
	print("Aim:", aim)
	print("Bullet Scene:", bullet_scene)
	
	# set starting checkpoint
	current_checkpoint = global_position
	#_change_shell(player.shellData)

func _physics_process(delta: float) -> void:
	match current_state:
		state.DEFAULT:
			apply_gravity(delta)
			if can_jump:
				handle_jump()
			movement(delta)
		state.DEATH:
			sprite.visible = false
		state.DASH:
			apply_gravity(delta)
			gravity = 980 / 8
			velocity.x = last_input * 400
			if is_on_wall():
				camera.apply_shake(10)
				current_state = state.DEFAULT
			move_and_slide()
	
	match current_powerup:
		powerup.NONE:
			pass
		powerup.FASTFALL:
			powerup_abilites.fastfall_ability()
		powerup.DASH:
			powerup_abilites.dash_ability(delta)
	
	
	
	# FOR TESTING ONLY REMOVE BEFORE RELEASE
	if Input.is_action_just_pressed("kill_button"):
		on_death()

var last_input: int = 1
func movement(delta):
	# move left and right
	var input_axis = Input.get_axis("move_left", "move_right")
	#print(input_axis)
	if input_axis != 0:
		last_input = input_axis
		sprite.scale.x = input_axis
		velocity.x = move_toward(velocity.x, shellData.max_speed * input_axis, shellData.acceleration * delta)
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
			velocity.y = shellData.jump_strength
	else:
		if Input.is_action_just_released("jump") and velocity.y < shellData.jump_strength / 2:
			velocity.y = shellData.jump_strength / 2

# this is where we write what happens depending on which power up is collected
# gets called in power_up_pickup
func collect_powerup(name):
	match name:
		"fastfall":
			current_powerup = powerup.FASTFALL
		"dash":
			current_powerup = powerup.DASH
		_:
			print("Unknown powerup collected. ", name, " not valid")

func on_death():
	camera.apply_shake(15)
	current_state = state.DEATH
	Engine.time_scale = 0.5
	await get_tree().create_timer(1,false).timeout
	Engine.time_scale = 1
	
	gameOver.emit()

func respawn():
	lives -= 1
	if lives >= 0:
		get_node("Player UI/Hearts/Heart" + str(lives + 1)).texture = heart_textures[0]
	if lives > 0:
		self.global_position = current_checkpoint
	else:
		on_death()

#bullet code
@export var bullet_scene: PackedScene
@onready var aim = $Weapon/cannon/Cannon/Aim
@onready var weapon = $Weapon

@onready var cannon: Node2D = $Weapon/cannon


func _process(delta: float):
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	#weapon.rotation = direction.angle()
	
	if Input.is_action_pressed("shoot") and T_attack_cooldown == 0 and shellData.canShoot:
		shoot()
		T_attack_cooldown = shellData.attack_cooldown
	
	if shellData.canShoot:
		cannon.visible = true
		cannon.rotation = direction.angle() + PI/2
	else:
		cannon.visible = false
	
	if T_attack_cooldown != 0:
		T_attack_cooldown = move_toward(T_attack_cooldown,0,delta)
	
	#press r to restart level
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

func shoot():
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = aim.global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	#bullet.direction = (get_global_mouse_position() - aim.global_position).normalized()
	$Weapon/cannon/AnimationPlayer.play("RESET")
	$Weapon/cannon/AnimationPlayer.play("shoot")
	
	GlobalVariables._play_sfx(GUN_SFX.instantiate())


func _on_camera_limit_detection_area_entered(area: Area2D) -> void:
	if area is CameraLimiter:
		camera.camera_limit_manager.set_limiter(area)
		#print(area)


func _on_hurtbox_area_entered(area: Area2D) -> void:
	$Hurtbox/CollisionShape2D.set_deferred("disabled", true)
	respawn() #respawn covers death logic if not enough lives to respawn
	
	await get_tree().create_timer(2).timeout

	$Hurtbox/CollisionShape2D.set_deferred("disabled", false)
