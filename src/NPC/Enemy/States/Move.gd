extends State

export var gravity = 10
export var speed = 30

var velocity = Vector2()

func physics_process(delta: float) -> void:
	if owner.attack_trigger.is_colliding():
		_state_machine.transition_to("Move/Attack")

func enter(msg: Dictionary = {}) -> void:
	if owner.dead:
		_state_machine.state = "Death"
		return
	owner.stats.connect("damage_taken", self, "_on_Enemy_damage_taken")
	owner.stats.connect("health_depleted", self, "_on_Enemy_death")

func exit() -> void:
	owner.stats.disconnect("damage_taken", self, "_on_Enemy_damage_taken")
	owner.stats.disconnect("health_depleted", self, "_on_Enemy_death")

func _on_Enemy_damage_taken() -> void:
	_state_machine.transition_to("Move/TakeHit")

func _on_Enemy_death() -> void:
	_state_machine.transition_to("Death")

func flipDirection() -> void:
	if (owner.direction == owner.DIRECTION_RIGHT):
		owner.direction = owner.DIRECTION_LEFT
	elif (owner.direction == owner.DIRECTION_LEFT):
		owner.direction = owner.DIRECTION_RIGHT
