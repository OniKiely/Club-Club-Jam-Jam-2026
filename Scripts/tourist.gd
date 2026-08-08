extends CharacterBody2D

var health = 3
var sprites = [preload("uid://t5q0xd6sah0b"), preload("uid://sep4r50a3uws"), preload("uid://cewrjpaegkqcx")]

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
		#$StateMachine.stop()
		$Sprite2D.hide()
		$CPUParticles2D.emitting = true
		await $CPUParticles2D.finished
		queue_free()
	else:
		$Sprite2D.texture = sprites[3 - health]
