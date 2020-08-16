extends State

signal onSplatter

onready var timer = $StunTimer

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter()
	owner.skin.play("take_hit")
	if owner.enable_blood:
		emit_signal("onSplatter")
	
	timer.start()

func exit() -> void:
	var move = get_parent()
	move.exit()

func _on_StunTimer_timeout():
	if not owner.attack_trigger.is_colliding():
		get_parent().flipDirection()
	_state_machine.transition_to("Move/Roaming")
