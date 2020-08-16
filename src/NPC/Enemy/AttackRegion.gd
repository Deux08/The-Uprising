extends DamageSource

func _ready() -> void:
	damage = get_node("../stats").attack
