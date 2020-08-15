extends State

signal jumped

onready var jump_delay: Timer = $JumpDelay
onready var controls_freeze: Timer = $ControlsFreeze

export var acceleration_x: = 2500.0


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	
	if event.is_action_pressed("jump"):
		owner.skin.play("jump")
		emit_signal("jumped")
		if move.velocity.y >= 0.0 and jump_delay.time_left > 0.0:
			move.velocity = calculate_jump_velocity(move.jump_impulse)
	else:
		move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	
	# Sign function returns a value of -1 or 1 depending on the input parameter.
	var direction: Vector2 = move.get_move_direction() if controls_freeze.is_stopped() else Vector2(sign(move.velocity.x), 1.0)
	move.velocity = move.calculate_velocity(move.velocity, move.max_speed, move.acceleration, delta, direction)
	if owner.talking:
		return
	move.velocity = owner.move_and_slide(move.velocity, owner.FLOOR_NORMAL)
	Events.emit_signal("player_moved", owner)
	
	if move.velocity.y < 0:
		owner.skin.play("rising")	
	elif move.velocity.y > 0:
		owner.skin.play("fall") 

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
	if "wall_jump" in msg:
		controls_freeze.start()
		move.max_speed.x = max(move.max_speed_default.x, abs(move.velocity.x))
		move.acceleration.y = move.acceleration_default.y
	

	
	jump_delay.start()

func exit() -> void:
	var move: = get_parent()
	move.acceleration = move.acceleration_default
	move.exit()


"""
Returns a new velocity with a vertical impulse applied to it
"""
func calculate_jump_velocity(impulse: float = 0.0) -> Vector2:
	if owner.talking:
		return Vector2.ZERO
	var move: State = get_parent()
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		Vector2(0.0, impulse),
		1.0,
		Vector2.UP
	)
