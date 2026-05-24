extends Node
class_name FSM

signal on_state_transitioned(state_name: String)

@export var initial_state: NodePath

var current_state: State

func _ready() -> void:
	await owner.ready
	for child: State in get_children():
		child.fsm = self
	
	current_state = get_node(initial_state)
	current_state.enter_state()

func transition_to(new_state: String) -> void:
	if not has_node(new_state):
		return
	
	current_state.exit_state()
	current_state = get_node(new_state)
	current_state.enter_state()
	on_state_transitioned.emit(current_state.name)
	
