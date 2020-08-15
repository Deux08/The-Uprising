tool
extends Position2D
class_name Hook, "res://assets/Icons/icon_hook.svg"

signal hooked_onto_target(target_global_position)

onready var ray_cast: RayCast2D = $RayCast2D
onready var arrow: Node2D = $Arrow
onready var snap_detector: Area2D = $SnapDetector
onready var cooldown: Timer = $Cooldown
onready var target_circle: DrawingUtils = $TargetCirce
onready var aim_duration: Timer = $AimDuration

const HOOKABLE_PHYSICS_LAYER: = 2

var is_aiming: = false setget set_is_aiming
var is_active = true setget set_is_active

onready var _radius: float = snap_detector.calculate_length()

func _ready() -> void:
	if Engine.editor_hint:
		update()

func _draw() -> void:
	if not Engine.editor_hint:
		return
		
	var radius: float = snap_detector.calculate_length()
	DrawingUtils.draw_circle_outline(self, Vector2.ZERO, radius, Color.lightgreen)

func has_target() -> bool:
	var has_target: bool = snap_detector.has_target()
	if not has_target and ray_cast.is_colliding():
		var collider: = ray_cast.get_collider()
		has_target = collider.get_collision_layer_bit(HOOKABLE_PHYSICS_LAYER)
	return has_target


func can_hook() -> bool:
	return is_active and has_target() and cooldown.is_stopped()

func get_target_position() -> Vector2:
	return snap_detector.target.global_position if snap_detector.target else ray_cast.get_collision_point()
	
func get_hook_target() -> HookTarget:
	return snap_detector.target

func get_aim_direction() -> Vector2:
	var direction: = Vector2.ZERO
	direction = (get_global_mouse_position() - global_position).normalized()
	return direction

func set_is_active(value: bool) -> void:
	is_active = value
	set_process_unhandled_input(value)

func set_is_aiming(value: bool) -> void:
	is_aiming = value
	Engine.time_scale = 0.05 if is_aiming == true else 1.0

	if is_aiming:
		aim_duration.start()
	else:
		aim_duration.stop()

func _on_AimDuration_timeout():
	set_is_aiming(false)
