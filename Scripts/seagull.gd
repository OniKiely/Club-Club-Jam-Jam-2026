extends CharacterBody2D

@export var score:int = 100

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if self.velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	move_and_slide() #StateMachine handles the velocity 


func _on_detection_area_body_entered(body: Node2D) -> void:
	$StateMachine.switch_to("Follow")


func _on_detection_area_body_exited(body: Node2D) -> void:
	$StateMachine.switch_to("Wander")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	GlobalVariables.score += score
	if area.name == "bullet":
		area.delete()
	$StateMachine.stop()
	$AnimatedSprite2D.hide()
	$CPUParticles2D.emitting = true
	
	await get_tree().process_frame
	await get_tree().physics_frame
	$CollisionShape2D.disabled = true
	
	await $CPUParticles2D.finished
	queue_free()
