extends Node
class_name StateMachine, "res://assets/icons/state_machine.svg"
"""
Generic State Machine. Initializes states and delegates engine callbacks to the active state.

"""

export var initial_state: = NodePath()
export var disabled = false

onready var state: State = get_node(initial_state) setget set_state

# Used for debugging, hence the internal variable
onready var _state_name = state.name

func _init() -> void:
	add_to_group("state_machine")

func _ready():
	yield(owner, "ready")
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	if disabled:
		return
	if (event.is_action_pressed("debug_death")):
		transition_to("Death")
	state.unhandled_input(event)

func _physics_process(delta: float) -> void:
	if disabled:
		return
	state.physics_process(delta)

func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if disabled:
		return
	if not has_node(target_state_path):
		return
	var target_state: = get_node(target_state_path)

	state.exit()
	self.state = target_state
	state.enter(msg)

func set_state(value: State) -> void:
	if disabled:
		return
	state = value
	_state_name = state.name
