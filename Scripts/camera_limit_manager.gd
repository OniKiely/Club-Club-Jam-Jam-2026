extends Node2D

@onready var player = get_parent().get_parent()

@export var limit_transition_speed = 3
const MAX_LIMIT = 100000

var camera_bounds_x_min
var camera_bounds_y_min
var camera_bounds_x_max
var camera_bounds_y_max

var limit_left_target: float = -MAX_LIMIT
var limit_right_target: float = MAX_LIMIT
var limit_top_target: float = -MAX_LIMIT
var limit_bottom_target: float = MAX_LIMIT

func _ready() -> void:
	var camera_bounds = get_viewport_rect()
	camera_bounds_x_min = camera_bounds.position.x
	camera_bounds_y_min = camera_bounds.position.y
	camera_bounds_x_max = camera_bounds.end.x
	camera_bounds_y_max = camera_bounds.end.y

func _physics_process(delta: float) -> void:
	get_parent().limit_left = _calc_limit(get_parent().limit_left, limit_left_target, true)
	get_parent().limit_right = _calc_limit(get_parent().limit_right, limit_right_target, true)
	get_parent().limit_top = _calc_limit(get_parent().limit_top, limit_top_target, true)
	get_parent().limit_bottom = _calc_limit(get_parent().limit_bottom, limit_bottom_target, true)

func _calc_limit(current_limit, target_limit, is_x):
	if current_limit == target_limit:
		return current_limit
	var clamped_limit = _clamp_limit(current_limit, is_x)
	return _move_limit_toward(clamped_limit, target_limit)

func _clamp_limit(limit, is_x):
	var player_pos = player.global_position.x if is_x else player.global_position.y
	var is_limit_after_player = sign(limit - player_pos)
	var clamp_value
	if is_x:
		clamp_value = camera_bounds_x_max if is_limit_after_player else camera_bounds_x_min
	else:
		clamp_value = camera_bounds_y_max if is_limit_after_player else camera_bounds_y_min
	return minf(clamp_value, limit) if is_limit_after_player else maxf(clamp_value, limit)

func _move_limit_toward(current, target):
	if abs(current) >= MAX_LIMIT || abs(target) >= MAX_LIMIT:
		return target
	if current != target:
		return move_toward(current, target, limit_transition_speed)
	return target

func set_limiter(limiter, instant = false):
	limit_left_target = limiter.get_limit_left()
	limit_right_target = limiter.get_limit_right()
	limit_top_target = limiter.get_limit_top()
	limit_bottom_target = limiter.get_limit_bottom()
	
	if instant:
		get_parent().limit_left = limit_left_target
		get_parent().limit_right = limit_right_target
		get_parent().limit_top = limit_top_target
		get_parent().limit_bottom = limit_bottom_target
