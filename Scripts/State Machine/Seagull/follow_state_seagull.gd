extends state

var seagull = null
var player = null
var dir = Vector2(0, 0)
var speed = 100

var TRASH = preload("uid://k38chnonovla")

#calls once when the state is switched to
func enter() -> void:
	$AttackTimer.start()
	seagull = get_parent().get_parent()
	player = GlobalVariables.Player

#called each frame, but only when the state is active
func run(delta: float) -> void:
	#if too close, keep regular velocity
	if abs(seagull.global_position.x - player.global_position.x) < 50:
		pass
	#if player is to the left
	elif seagull.global_position.x > player.global_position.x:
		dir = Vector2(-1, 0) #dir is left
	else:
		dir = Vector2(1, 0)#dir is right
	seagull.velocity = dir * speed

#called when the state is switched out of
func exit() -> void:
	player = null
	$AttackTimer.stop()


func _on_attack_timer_timeout() -> void:
	var moved_pos = player.global_position + (player.velocity / 4)
	for i in range(3):
		var attack = TRASH.instantiate()
		var theta = (i * (PI/8)) - (PI/8) + seagull.global_position.angle_to_point(moved_pos)
		attack.dir = Vector2(cos(theta), sin(theta))
		attack.global_position = seagull.global_position
		get_tree().get_root().add_child(attack)
