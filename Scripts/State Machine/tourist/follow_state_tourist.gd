extends state

var tourist = null
var player = null
var dir = Vector2(0, 0)
var speed = 500

var TRASH = preload("uid://k38chnonovla")

#calls once when the state is switched to
func enter() -> void:
	$AttackTimer.start()
	tourist = get_parent().get_parent()
	player = GlobalVariables.Player

#called each frame, but only when the state is active
func run(delta: float) -> void:
	#if too close, keep regular velocity
	if abs(tourist.global_position.x - (player.global_position.x + (player.velocity.x / 3))) < 20:
		pass
	#if player is to the left
	elif tourist.global_position.x > player.global_position.x:
		dir = Vector2(-1, 0) #dir is left
	else:
		dir = Vector2(1, 0)#dir is right
	tourist.velocity = dir * speed

#called when the state is switched out of
func exit() -> void:
	player = null
	$AttackTimer.stop()

func _on_attack_timer_timeout() -> void:
	get_parent().switch_to("Attack")
