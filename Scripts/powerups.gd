extends Node2D

@onready var player = get_parent()

# we need to add a hitbox to the player when falling once we have added an enemy
# and hitbox/hurtbox collision
var fastfall_speed: int = 100
func fastfall_ability():
	if Input.is_action_pressed("ability"):
		player.can_jump = false
		player.gravity = 980 * 2
		player.current_speed = fastfall_speed
	else:
		player.gravity = 980
		player.can_jump = true
		player.current_speed = player.default_speed

func dash_ability(delta):
	if Input.is_action_just_pressed("ability"):
		$"../DashTimer".start()
		player.velocity.y -= 50
		player.current_state = player.state.DASH


func _on_dash_timer_timeout() -> void:
	player.gravity = 980
	player.current_state = player.state.DEFAULT
