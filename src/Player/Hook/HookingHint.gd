tool
extends DrawingUtils

export var color: Color = COLOR_BLUE_LIGHT
export var radius: = 5.0

func _ready() -> void:
	# Setting as top level as when the player moves the cursor, we do not want the HookingHint to move as well
	set_as_toplevel(true)
	update()

func _draw() -> void:
	draw_circle_outline(self, Vector2.ZERO, radius+2, color, 4.0)
	draw_circle(Vector2.ZERO, radius, color)
