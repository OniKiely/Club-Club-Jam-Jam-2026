extends Node2D

@onready var particles1: Node2D = $Parallax2D2/particles
@onready var particles2: Node2D = $Parallax2D3/particles


@export var P_particle:PackedScene

@export var emitSpeed:float = 0.2
var T_emitSpeed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if T_emitSpeed == 0:
		_emit_particle()
		T_emitSpeed = emitSpeed
	else:
		T_emitSpeed = move_toward(T_emitSpeed,0,delta)

func _emit_particle():
	var particle = P_particle.instantiate()
	particle.global_position.x = randf_range(-600,600)
	particle.global_position.y = 100
	if GlobalVariables.Player:
		particle.global_position += 0.2 * GlobalVariables.Player.position
	particles1.add_child(particle)
	particle = P_particle.instantiate()
	particle.global_position.x = randf_range(-600,600)
	particle.global_position.y = 100
	if GlobalVariables.Player:
		particle.global_position += 0.4 * GlobalVariables.Player.position
	particles2.add_child(particle)
