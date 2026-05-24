extends Area2D
class_name Enemy

@export var max_health: float = 10
@export var damage: float = 2.0
@export var exp_amount: float = 20.0

@onready var health_component: HealthComponent = $HealthComponent
@onready var selector: Sprite2D = $Selector

func _ready() -> void:
	health_component.setup(max_health)

func select_enemy() -> void:
	selector.show()

func deselect_enemy() -> void:
	selector.hide()
