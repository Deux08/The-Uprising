extends Node
class_name State, "res://Assets/Icons/state.svg"
"""
State interface to use in Hierarchical State Machines.

"""

onready var _state_machine: = _get_state_machine(self)

# The underscores for unhandled_input and physics_process are removed as we do not want Godot to automatically call the two functions on runtime
# We want to delegate the StateMachine to explicitly call them
# We only want one state active
# If the underscores is added we will need to do something like this in the State Script
# func _ready() -> void:
# 	set_physics_process(false)
# 	set_process_unhandled_input(false)
# But that is unnecessary

func unhandled_input(event: InputEvent) -> void:
	return

func physics_process(delta: float) -> void:
	return

# This method is to enter into the state
func enter(msg: Dictionary = {}) -> void:
	return

func exit() -> void:
	return

func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node
