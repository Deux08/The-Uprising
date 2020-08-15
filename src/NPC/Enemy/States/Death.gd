extends State

func enter(msg: Dictionary = {}) -> void:
	owner.skin.play("die")
	owner.deactivate()

