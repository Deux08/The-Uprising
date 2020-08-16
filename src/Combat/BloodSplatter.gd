extends Node2D

export var BloodParticleScene: PackedScene
export var BloodParticleNumber: = 15
export var RandomVelocity: = 300.0
export var selectedNode: = NodePath()

const BLOODSPLATTERSIGNALNAME: = "onSplatter"

onready var detectedNode = get_node(selectedNode)
var rnd = RandomNumberGenerator.new()

func _ready():
	for detectSignal in detectedNode.get_signal_list():
		if(detectSignal["name"] == BLOODSPLATTERSIGNALNAME):
			detectedNode.connect(BLOODSPLATTERSIGNALNAME, self, "on_Trigger")
	rnd.randomize()

func on_Trigger():
	splatter()

func splatter(particles_to_spawn: = -1):
	if (particles_to_spawn <= 0):
		particles_to_spawn = BloodParticleNumber
	
	var spawnedParticle: RigidBody2D
	
	for i in range(particles_to_spawn):
		spawnedParticle = BloodParticleScene.instance()
		
		get_tree().root.call_deferred("add_child", spawnedParticle)
		
		spawnedParticle.global_position = global_position
		
		spawnedParticle.linear_velocity = Vector2(rnd.randf_range(-RandomVelocity,RandomVelocity), rnd.randf_range(-RandomVelocity, RandomVelocity))
