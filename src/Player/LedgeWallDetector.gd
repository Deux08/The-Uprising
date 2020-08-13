class_name LedgeWallDetector
extends Position2D

onready var ray_bottom: RayCast2D = $RayBottom
onready var ray_top: RayCast2D = $RayTop

export var is_active: = true

func _ready() -> void:
	# Ensures that the rays are pointing to the right, to avoid breaking the code
	assert(ray_top.cast_to.x >= 0)
	assert(ray_bottom.cast_to.x >= 0)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		scale.x = -1
	if event.is_action_pressed("move_right"):
		scale.x = 1


func is_against_ledge() -> bool:
	return is_active and ray_bottom.is_colliding() and not ray_top.is_colliding()
	
func is_against_wall() -> bool:
	return is_active and (ray_bottom.is_colliding() or ray_top.is_colliding())
	
func get_cast_to_directed() -> Vector2:
	return ray_top.cast_to * scale

func get_top_global_position() -> Vector2:
	return ray_top.global_position
