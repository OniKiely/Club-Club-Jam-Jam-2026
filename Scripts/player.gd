extends CharacterBody2D

@onready var sprite = $Sprite2D

var speed: int = 175
var acceleration: int = 700
var friction = 900
var jump_strength = -350
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_state = state.DEFAULT
enum state {
	DEFAULT,
	DEATH
}


func _physics_process(delta: float) -> void:
	match current_state:
		state.DEFAULT:
			apply_gravity(delta)
			handle_jump()
			movement(delta)
		state.DEATH:
			pass

func movement(delta):
	# move left and right
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis != 0:
		sprite.flip_h = (input_axis < 0) # flips sprite depending on move axis
		velocity.x = move_toward(velocity.x, speed * input_axis, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	move_and_slide()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

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
