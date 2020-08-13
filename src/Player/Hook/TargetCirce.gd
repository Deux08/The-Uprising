tool
extends DrawingUtils

export var offset: = Vector2(50.0, 0) setget set_offset
export var color: = Color(0.815682, 0.859375, 0.060425) setget set_color

func _draw() -> void:
	draw_circle_outline(self, offset, 3.0, color, 2.0)

func set_offset(value: Vector2) -> void:
	offset = value
	update()

func set_color(value: Color) -> void:
	color = value
	update()
