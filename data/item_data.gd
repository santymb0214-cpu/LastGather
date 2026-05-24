extends Item
class_name ItemData

enum Type {
	COMIDA, MEDICAMENTOS, SCROLL, EQUIPAMIENTO
}


@export var type: Type
@export var can_drop: bool
@export var is_consumible: bool
@export var max_stack: int = 999
