extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0, -1)
const DIRECTION_RIGHT = "Right"
const DIRECTION_LEFT = "Left"

export(String) var direction = "Right"

export var dead = false

onready var state_machine: StateMachine = $StateMachine

onready var collision: CollisionShape2D = $CollisionShape2D

onready var skin: Node2D = $Skin
onready var raycast: RayCast2D = $RayCast2D
onready var attack_trigger: RayCast2D = $AttackTrigger

# Health and Combat related
onready var stats: Stats = $Stats
onready var health_bar: Control = $HealthBar
onready var attack_radius: Area2D = $AttackRadius
onready var hitbox: Area2D = $HitBox
onready var hurtbox: DamageSource = $HurtBox
export(bool) var enable_blood = true

func take_damage(source: Hit) -> void:
	stats.take_damage(source)
	health_bar._on_health_updated(stats.health, source.damage)

func deactivate() -> void:
	dead = true
	state_machine.disabled = true
	remove_child(health_bar)
	remove_child(attack_radius)
	remove_child(hitbox)
	remove_child(hurtbox)
	remove_child(raycast)
	remove_child(attack_trigger)
	remove_child(stats)
	remove_child(collision)
