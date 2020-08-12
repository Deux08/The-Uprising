tool
extends Node2D

export var color: Color
export var radius: = 12.0

func _ready() -> void:
	# Setting as top level as when the player moves the cursor, we do not want the HookingHint to move as well
	set_as_toplevel(true)
	update()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color)
