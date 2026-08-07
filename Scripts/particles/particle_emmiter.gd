extends Node2D

@export var trail:Node2D


@export var P_particle:PackedScene

var emitting = true
@export var emitSpeed:float = 0.2
var T_emitSpeed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if emitting:
		if T_emitSpeed == 0:
			_emit_particle()
			T_emitSpeed = emitSpeed
		else:
			T_emitSpeed = move_toward(T_emitSpeed,0,delta)

func _emit_particle():
	var particle = P_particle.instantiate()
	if trail:
		particle.initialVelocity = trail.velocity/4
		particle.position = global_position
		#print(particle.initialVelocity)
	GlobalVariables.Particles.add_child(particle)
