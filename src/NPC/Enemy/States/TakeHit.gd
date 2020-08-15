extends State

onready var timer = $StunTimer

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter()
	owner.skin.play("take_hit")
	timer.start()

func exit() -> void:
	var move = get_parent()
	move.exit()

func _on_StunTimer_timeout():
	_state_machine.transition_to("Move/Roaming")
