extends Area2D
class_name CameraLimiter

enum limitX {NONE, LEFT, RIGHT}
enum limitY {NONE, TOP, BOTTOM}

const MAX_VAL = 100000

@export var limit_x: limitX = limitX.NONE
@export var limit_y: limitY = limitY.NONE

@onready var marker = $LimitPosition

func get_limit_top():
	if limit_y != limitY.TOP:
		return -MAX_VAL
	return marker.global_position.y

func get_limit_bottom():
	if limit_y != limitY.BOTTOM:
		return MAX_VAL
	return marker.global_position.y

func get_limit_left():
	if limit_x != limitX.LEFT:
		return -MAX_VAL
	return marker.global_position.x

func get_limit_right():
	if limit_x != limitX.RIGHT:
		return MAX_VAL
	return marker.global_position.x
