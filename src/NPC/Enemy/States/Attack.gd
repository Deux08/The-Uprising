extends State

onready var timer: Timer = $AttackDelay

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent()
	move.enter(msg)
	if(owner.direction == owner.DIRECTION_RIGHT):
		if owner.attack_radius.transform.origin.x < 0:
			owner.attack_radius.transform.origin.x = abs(owner.attack_radius.transform.origin.x)
	elif (owner.direction == owner.DIRECTION_LEFT):
		if owner.attack_radius.transform.origin.x > 0:
			owner.attack_radius.transform.origin.x = -owner.attack_radius.transform.origin.x
	timer.start()

func exit() -> void:
	var move = get_parent()
	move.exit()
	owner.skin.disconnect("attackRegion", self, "_on_attackRegion_animation")
	owner.skin.disconnect("animation_finished", self, "_on_Enemy_animation_finished")
	owner.attack_radius.attack(false)
	timer.stop()


func _on_AttackDelay_timeout():
	owner.skin.play("attack")
	owner.skin.connect("attackRegion", self, "_on_attackRegion_animation")
	owner.skin.connect("animation_finished", self, "_on_Enemy_animation_finished")
	

func _on_Enemy_animation_finished(name: String) -> void:
	_state_machine.transition_to("Move/Roaming")

func _on_attackRegion_animation() -> void:
	owner.attack_radius.attack(true)
