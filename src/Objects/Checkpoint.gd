extends Area2D
signal checkpoint(location)

onready var player_text = get_node("../Player/Interact/PlayerSaveCheckPoint")
onready var player = get_node("../Player")
onready var label = $Label

var checkpoint_active: = false
var checkpoint_location: = Vector2.ZERO

func _ready():
	connect("checkpoint", player, "_set_Player_respawn_point")

func _unhandled_input(event) -> void:
	if checkpoint_active:
		if (event.is_action_pressed("interact")):
			checkpoint_location = get_position()
			emit_signal("checkpoint", checkpoint_location)


func _on_Checkpoint_area_entered(area):
	checkpoint_active = true
	player_text.show()
	label.show()


func _on_Checkpoint_area_exited(area):
	checkpoint_active = false
	player_text.hide()
	label.hide()
