extends State

func _on_Player_animation_finished(anim_name: String) -> void:
	var move = get_parent()
	if owner.is_on_floor():
		if move.get_move_direction().x == 0.0:
			_state_machine.transition_to("Move/Idle")
		else:
			_state_machine.transition_to("Move/Run")
	else:
		_state_machine.transition_to("Move/Air")

func physics_process(delta: float) -> void:
	var move = get_parent()
	if owner.is_on_floor():
		return
	move.physics_process(delta)

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter()
	if(move.direction == move.DIRECTION_RIGHT):
		if owner.attack_radius.transform.origin.x < 0:
			owner.attack_radius.transform.origin.x = abs(owner.attack_radius.transform.origin.x)
	elif (move.direction == move.DIRECTION_LEFT):
		if owner.attack_radius.transform.origin.x > 0:
			owner.attack_radius.transform.origin.x = -owner.attack_radius.transform.origin.x
	owner.skin.play("slash")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	owner.attack_radius.attack(true)

func exit() -> void:
	var move = get_parent()
	move.exit()
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")
	owner.attack_radius.attack(false)
