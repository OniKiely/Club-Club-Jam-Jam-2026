extends CharacterBody2D

@export var score:int = 100

var health = 3
var sprites = [preload("uid://baavvfkfkpvhm"), preload("uid://wpoxuli16cpg"), preload("uid://ctfyoxhhmhqne")]
var BULLET = preload("uid://k38chnonovla")

func _ready() -> void:
	$AnimationPlayer.play("attack")

func _process(delta: float) -> void:
	if self.velocity.x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
	move_and_slide() #StateMachine handles the velocity 


func _on_detection_area_body_entered(body: Node2D) -> void:
	$StateMachine.switch_to("Follow")


func _on_detection_area_body_exited(body: Node2D) -> void:
	$StateMachine.switch_to("Wander")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= 1
	if area.name == "Bullet":
		area.delete()
	if health == 0:
		GlobalVariables.score += score
		#$StateMachine.stop()
		$Sprite2D.hide()
		$CPUParticles2D.emitting = true
		await $CPUParticles2D.finished
		queue_free()
	else:
		if health > 0:
			$Sprite2D.texture = sprites[3 - health]

func attack():
	var tween = create_tween()
	var old_pos_y = self.global_position.y
	var pos = Vector2(self.global_position.x, GlobalVariables.Player.global_position.y + 20)
	tween.tween_property(self, "global_position", pos, 1)
	tween.tween_property(self, "global_position", Vector2(self.global_position.x, old_pos_y), 1.5)
	await get_tree().create_timer(1).timeout
	for i in 2:
		var instance = BULLET.instantiate()
		var theta = -3*PI/8 - (i*PI/8)
		instance.global_position = $Marker2D2.global_position
		instance.dir = Vector2(cos(theta), sin(theta))
		instance.speed = 300
		instance.gravity_mult = 400
		get_tree().get_root().add_child(instance)
	for a in 2:
		var instance = BULLET.instantiate()
		var theta = -5*PI/8 + (a*PI/8)
		instance.global_position = $Marker2D.global_position
		instance.dir = Vector2(cos(theta), sin(theta))
		instance.speed = 300
		instance.gravity_mult = 400
		get_tree().get_root().add_child(instance)
