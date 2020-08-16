extends State

func _ready() -> void:
	yield(owner, "ready")
	owner._start_position = owner.position
	

func _on_Player_animation_finished(anim_name: String) -> void:
	_state_machine.transition_to('Move/Idle')


func enter(msg: Dictionary = {}) -> void:
	owner.stats.set_invulnerable_for_seconds(2)
	owner.is_active = false
	owner.camera_rig.is_active = false
	owner.position = owner._start_position
	owner.skin.play("spawn")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished")
	owner.health_bar._on_health_updated(owner.stats.max_health, 0)
	owner.stats.heal(owner.stats.max_health)


func exit() -> void:
	owner.stats.heal(owner.stats.max_health)
	owner.is_active = true
	owner.camera_rig.is_active = true
	owner.hook.visible = true
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")
