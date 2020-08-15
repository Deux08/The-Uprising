extends KinematicBody2D
class_name Player

onready var state_machine: StateMachine = $StateMachine

onready var skin: Node2D = $Skin

onready var collider: CollisionShape2D = $CollisionShape2D

onready var hook: Hook = $Hook

# Environment detection nodes for movement characteristics
onready var ledge_wall_detector: LedgeWallDetector = $LedgeWallDetector
onready var floor_detector: FloorDetector = $FloorDetector
onready var pass_through: Area2D = $PassThrough

# Camera Node
onready var camera_rig: Position2D = $CameraRig
onready var scenic_camera: Camera2D = $ScenicCamera

# Health and Combat related nodes
onready var stats: Stats = $Stats
onready var health_bar: Control = $HealthBar

# FLOOR NORMAL is a variable that affects which direction is the floor.
# Vector2.UP is a Vector2(0,-1) value. the -1 y value indicates that the top is up and the bottom is down.
# -1 is going up in Godot
# Places where you might need to use FLOOR_NORMAL is in functions like move_and_slide
const FLOOR_NORMAL: = Vector2.UP

# Gonna be automatically true when the Player node is created
var is_active = true setget set_is_active
var _start_position: Vector2

# This is variable is used for dialogues
var talking = false

func _ready() -> void:
	# The signal comes from the Stats node
	stats.connect("health_depleted", self, "_on_Player_health_depleted")
	health_bar._on_max_health_updated(stats.max_health)
	activate_scenic_camera(false)
	


func take_damage(source: Hit) -> void:
	stats.take_damage(source)
	health_bar._on_health_updated(stats.health, source.damage)

func _on_Player_health_depleted() -> void:
	state_machine.transition_to("Death")

# Changing between cameras
func activate_scenic_camera(activate: bool):
	# Camera used for player movement
	camera_rig.camera.current = not activate
	# Camera used for cut scenes
	scenic_camera.current = activate

func set_is_active(value: bool) -> void:
	is_active = value
	# Check if the Collider has not been set yet
	if not collider:
		return
	collider.disabled = not value	
	hook.is_active = value
	ledge_wall_detector.is_active = value

func _set_Player_respawn_point(location: Vector2) -> void:
	_start_position = location
