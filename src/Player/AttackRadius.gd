extends DamageSource

onready var region = $CollisionShape2D

func _ready() -> void:
	add_to_group("Player_Attack")

func attack(activate: bool) -> void:
	if activate:
		region.disabled = false	
	else:
		region.disabled = true
