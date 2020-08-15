extends State

onready var timer: Timer = $AttackDelay

func enter(msg: Dictionary = {}) -> void:
	timer.start()

func exit() -> void:
	owner.attack_radius.attack(false)

func _on_AttackDelay_timeout():
	owner.skin.play("attack")
	owner.skin.connect("animation_finished", self, "_on_Enemy_animation_finished")
	owner.attack_radius.attack(true)

func _on_Enemy_animation_finished() -> void:
	_state_machine.transition_to("Move/Roaming")
