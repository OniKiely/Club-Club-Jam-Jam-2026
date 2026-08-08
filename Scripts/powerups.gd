extends Node2D


# we need to add a hitbox to the player when falling once we have added an enemy
# and hitbox/hurtbox collision
var fastfall_speed: int = 100
func fastfall_ability():
	if Input.is_action_pressed("ability"):
		get_parent().can_jump = false
		get_parent().gravity = 980 * 2
		get_parent().current_speed = fastfall_speed
	else:
		get_parent().gravity = 980
		get_parent().can_jump = true
		get_parent().current_speed = get_parent().default_speed
