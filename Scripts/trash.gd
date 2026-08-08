extends Node2D

var dir = Vector2(0, 0)
var speed = 200
var gravity = 0

func _process(delta: float) -> void:
	self.global_position += dir * speed * delta
	self.global_position.y += delta * gravity
	gravity += delta * 160

func _on_area_2d_body_entered(body: Node2D) -> void:
	$Sprite2D.hide()
	$GPUParticles2D.emitting = true
	if body.name == "player":
		pass
	else:
		pass
	await $GPUParticles2D.finished
	queue_free()
