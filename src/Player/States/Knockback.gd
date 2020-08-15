extends State

onready var timer = $Timer

func enter(msg: Dictionary = {}) -> void:
	owner.lock = true
	timer.start()

func exit() -> void:
	owner.lock = false


func _on_Timer_timeout():
	_state_machine.transition_to("Move/Idle")
