extends Node2D

signal animation_finished(name)

onready var anim: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	emit_signal("animation_finished", anim_name)

func play(anim_name: String) -> void:
	assert(anim_name in anim.get_animation_list())
	anim.stop()
	anim.play(anim_name)

func loop(anim_name: String, active: bool) -> void:
	assert(anim_name in anim.get_animation_list())
	var animation = anim.get_animation(anim_name)
	if active:
		animation.set_loop(active)
		anim.play(anim_name)
	else:
		animation.set_loop(active)
		anim.stop()
