extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine

onready var collider: CollisionShape2D = $CollisionShape2D

onready var hook: Hook = $Hook

const FLOOR_NORMAL: = Vector2.UP

# Gonna be automatically true when the Player node is created
var is_active = true setget set_is_active

func set_is_active(value: bool) -> void:
	is_active = value
	# Check if the Collider has not been set yet
	if not collider:
		return
	collider.disabled = not value	
