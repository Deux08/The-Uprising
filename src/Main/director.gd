extends Node

onready var camera = owner.player.scenic_camera


func zoom(end_value, duration):
	$Tween.interpolate_property(camera, "zoom", camera.zoom,
	end_value, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()


func move(end_pos, duration):
	$Tween.interpolate_property(camera, "position",
	camera.position, end_pos, duration,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()
	
