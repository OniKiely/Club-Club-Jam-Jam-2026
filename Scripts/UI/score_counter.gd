extends Node2D

@onready var score_count: Label = $"score count"
var lerpScore:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lerpScore = lerp(lerpScore,float(GlobalVariables.score),delta*20)
	score_count.text = "Score: " + str(int(round(lerpScore)))
