extends State

export var max_speed_sprint: = 900.0

func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event)

func physics_process(delta: float) -> void:
	var move: = get_parent()
	if owner.is_on_floor():
		if move.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")

	move.physics_process(delta)

# This method is to enter into the state
func enter(msg: Dictionary = {}) -> void:
	owner.skin.loop("run", true)
	get_parent().enter(msg)
	

func exit() -> void:
	owner.skin.loop("run", false)
	get_parent().exit()
