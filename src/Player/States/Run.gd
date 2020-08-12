extends State

export var max_speed_sprint: = 900.0

func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event)

func physics_process(delta: float) -> void:
	var move = get_parent()
	move.max_speed.x = max_speed_sprint if Input.is_action_pressed("sprint") else move.max_speed_default.x
	
	if owner.is_on_floor() and move.velocity.length() < 1.0:
		_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air")
	move.physics_process(delta)

# This method is to enter into the state
func enter(msg: Dictionary = {}) -> void:
	get_parent().enter(msg)

func exit() -> void:
	get_parent().exit()
