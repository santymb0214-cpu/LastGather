#revisa los estados
extends Node
class_name FSM


signal on_state_transitioned(state_name: String)

#variable para el estado inicial
@export var initial_state: NodePath


#estado actual de la entidad
var current_state: State


#funcion ready para poder iniciar todos los estados
func _ready() -> void:
	#utilizar await para esperar que el owner ya cargo por completo
	await owner.ready
	for child: State in get_children():
		child.fsm = self
	#estado inicial
	current_state = get_node(initial_state)
	current_state.enter_state()


func transition_to(new_state: String) -> void:
	if not has_node(new_state):
		return
	current_state.exit_state()
	current_state = get_node(new_state)
	current_state.enter_state()
	on_state_transitioned.emit(current_state.name)
