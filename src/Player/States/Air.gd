extends State

signal jumped

onready var jump_delay: Timer = $JumpDelay

export var acceleration_x: = 5000.0


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	
	if event.is_action_pressed("jump"):
		emit_signal("jumped")
		if move.velocity.y >= 0.0 and jump_delay.time_left > 0.0:
			move.velocity = calculate_jump_velocity(move.jump_impulse)
	else:
		move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)

	# Landing
	if owner.is_on_floor():
		var target_state: = "Move/Idle" if move.get_move_direction().x == 0 else "Move/Run"
		_state_machine.transition_to(target_state)
	elif owner.ledge_wall_detector.is_against_ledge():
		_state_machine.transition_to("Ledge", {move_state=move})
	
	if owner.is_on_wall():
		var wall_normal: float = owner.get_slide_collision(0).normal.x
		_state_machine.transition_to("Move/Wall", { normal = wall_normal, velocity = move.velocity })

func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	
	move.acceleration.x = acceleration_x
	if "velocity" in msg:
		move.velocity = msg.velocity 
		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
	if "impulse" in msg:
		move.velocity += calculate_jump_velocity(msg.impulse)
	jump_delay.start()

func exit() -> void:
	var move: = get_parent()
	move.acceleration = move.acceleration_default
	move.exit()


"""
Returns a new velocity with a vertical impulse applied to it
"""
func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	var move: State = get_parent()
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		1.0,
		Vector2.UP
	)
