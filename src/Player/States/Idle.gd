extends State

func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)

func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor() and move.get_move_direction().x != 0.0:
		_state_machine.transition_to("Move/Run")
	elif not owner.is_on_floor():
		_state_machine.transition_to("Move/Air")

# This method is to enter into the state
func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	
	# Object Oriented, can access object variables
	move.max_speed = move.max_speed_default
	move.velocity = Vector2.ZERO
	owner.skin.loop("idle", true)

func exit() -> void:
	owner.skin.loop("idle", false)
	get_parent().exit()

