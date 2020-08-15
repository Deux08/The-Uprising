extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0, -1)
const DIRECTION_RIGHT = "Right"
const DIRECTION_LEFT = "Left"

var direction = "Right"

onready var sprite: AnimatedSprite = $AnimatedSprite
onready var raycast: RayCast2D = $RayCast2D


