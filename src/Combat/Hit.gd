class_name Hit

var damage := 0
var is_instakill := false

func _init(source: DamageSource) -> void:
	damage = source.damage
	is_instakill = source.is_instakill
