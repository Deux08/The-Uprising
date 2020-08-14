extends State
"""
Parent state that abstracts and handles basic movement
Move-related children states can delegate movement to it, or use its utility functions
"""

const PASS_THROUGH_LAYER = 3
const DIRECTION_RIGHT = "Right"
const DIRECTION_LEFT = "Left"

export var max_speed_default: = Vector2(500.0, 1500.0)
export var acceleration_default: = Vector2(100000, 3000.0)
export var jump_impulse: = 900.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO
var direction = "Right"

func _on_Hook_hooked_onto_target(target_global_position: Vector2) -> void:
	var to_target: Vector2 = target_global_position - owner.global_position
	if owner.is_on_floor() and to_target.y > 0.0:
		return

	_state_machine.transition_to("Hook", {target_global_position = target_global_position, velocity = velocity})

func _on_PassThrough_body_exited(body) -> void:
	owner.set_collision_mask_bit(PASS_THROUGH_LAYER, true)

func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", { impulse = jump_impulse })
	if event.is_action_pressed("toggle_debug_move"):		
		_state_machine.transition_to("Debug")
	
	if event.is_action_pressed("move_down") and owner.is_on_floor():
		owner.set_collision_mask_bit(PASS_THROUGH_LAYER, false)
		_state_machine.transition_to("Move/Air")
	elif event.is_action_released("move_down") and not owner.get_collision_mask_bit(PASS_THROUGH_LAYER):
		owner.set_collision_mask_bit(PASS_THROUGH_LAYER, true)

func physics_process(delta: float) -> void:
	velocity = calculate_velocity(velocity, max_speed, acceleration, delta, get_move_direction())
	velocity = owner.move_and_slide(velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)


func enter(msg: Dictionary = {}) -> void:
	owner.hook.connect("hooked_onto_target", self, "_on_Hook_hooked_onto_target", [], CONNECT_DEFERRED)
	owner.stats.connect("damage_taken", self, "_on_Stats_damage_taken")
	$Air.connect("jumped", $Idle.jump_delay, "start")
	owner.pass_through.connect("body_exited", self, "_onPassThrough_body_exited")

func exit() -> void:
	owner.hook.disconnect("hooked_onto_target", self, "_on_Hook_hooked_onto_target")
	owner.stats.disconnect("damage_taken", self, "_on_Stats_damage_taken")
	$Air.disconnect("jumped", $Idle.jump_delay, "start")
	owner.pass_through.disconnect("body_exited", self, "_onPassThrough_body_exited")

static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity: = old_velocity

	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)

	return new_velocity


func get_move_direction() -> Vector2:
	var horizontal_move_direction: = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (horizontal_move_direction > 0):
		direction = DIRECTION_RIGHT
		owner.skin.sprite.set_flip_h(false)
	elif (horizontal_move_direction < 0):
		direction = DIRECTION_LEFT
		owner.skin.sprite.set_flip_h(true)
		
	return Vector2(
		horizontal_move_direction,
		1.0
	)
