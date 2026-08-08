extends Node2D

var dir = Vector2(0, 0)
var speed = 250
var gravity = 0

func _process(delta: float) -> void:
	self.global_position += dir * speed * delta
	self.global_position.y += delta * gravity
	gravity += delta * 200

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !body.is_in_group("enemy"):
		$Sprite2D.hide()
		$CPUParticles2D.emitting = true
		if body.name == "player":
			pass
		else:
			pass
		await $CPUParticles2D.finished
		queue_free()
