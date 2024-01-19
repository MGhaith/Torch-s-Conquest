# Generic state machine. Initializes states and delegates engine callbacks
# (_physics_process, _unhandled_input) to the active state.
class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal transitioned(state_name)

@export var initial_state : State

var current_state: State
var states: Dictionary = {}
# Variable to track the last state before changing to a new
# This variable is used to take actions in other scripts, based on the last state
var last_state: State


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition.bind(child))
	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)


func on_child_transition(new_state_name: String, old_state: State):
	if not old_state == current_state:
		push_error("%s transitioned when not current state" % old_state.name)
		return
	# Assigns the current state to the last state variable before changing
	last_state = current_state
	var new_state = states.get(new_state_name.to_lower())
	if not new_state:
		push_error("State %s not found" % new_state_name)
		return
	if current_state:
		current_state.exit()
	new_state.enter()
	current_state = new_state
