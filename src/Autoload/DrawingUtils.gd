tool
"""
Functions to draw shapes unavailable in CanvasItem
"""
extends Node2D

const DEFAULT_POINTS_COUNT: = 32

const COLOR_BLUE_LIGHT: = Color("09a6ca")
const COLOR_BLUE_DEEP: = Color("0046ff")

const COLOR_SUCCESS: = Color("2cb638")
const COLOR_WARNING: = Color("ff9b00")
const COLOR_ERROR: = Color("ff004e")


static func draw_circle_outline(obj: CanvasItem=null, position:=Vector2.ZERO, radius:float=30.0, color:=Color(), thickness:=1.0) -> void:
	var points_array: = PoolVector2Array()
	for i in range(DEFAULT_POINTS_COUNT + 1):
		var angle: = 2 * PI * i / DEFAULT_POINTS_COUNT
		var point: = position + Vector2(cos(angle) * radius, sin(angle) * radius)
		points_array.append(point)
	obj.draw_polyline(points_array, color, thickness, true)
