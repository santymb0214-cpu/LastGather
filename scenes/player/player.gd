extends CharacterBody2D
class_name Player

@export_group("Stats")
@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 60.0
@export var damage: float = 5.0
@export var crit_chance: float = 0.0
@export var crit_damage: float = 0.0

@export_group("Exp")
@export var base_exp: float = 100.0
@export var exp_multiplier: float = 2.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var fsm: FSM = $FSM

@onready var weapon: Node2D = $Weapon
@onready var enemy_attack_area: Area2D = %EnemyAttackArea

@onready var attack_pos: Dictionary = {
	"down": %Down,
	"up": %Up,
	"right": %Right,
	"left": %Left
}

var curr_mana: float = 0.0
var curr_exp: float = 0.0
var next_level_exp: float = 0.0

var curr_level: int = 1
var curr_points: int = 0

var last_direction: String = "down"

func _process(delta: float) -> void:
	fsm.current_state.process_state(delta)

func setup() -> void:
	reset_health()
	reset_mana()
	next_level_exp = base_exp

func reset_health() -> void:
	health_component.setup(max_health)
	EventBus.on_player_health_updated.emit(max_health, max_health)

func reset_mana() -> void:
	curr_mana = max_mana
	EventBus.on_player_mana_updated.emit(curr_mana, max_mana)

func use_mana(value: float) -> void:
	curr_mana = max(curr_mana - value, 0)
	EventBus.on_player_mana_updated.emit(curr_mana, max_mana)

func add_exp(value: float) -> void:
	curr_exp += value
	while curr_exp >= next_level_exp:
		level_up()
	
	EventBus.on_player_new_level.emit(curr_exp, next_level_exp)

func level_up() -> void:
	curr_exp -= next_level_exp
	curr_level += 1
	curr_points += 4
	next_level_exp *= exp_multiplier
	EventBus.on_player_stats_updated.emit()

func is_moving() -> bool:
	var move_input = ["move_down", "move_left", "move_right", "move_up"]
	for input in move_input:
		if Input.is_action_pressed(input):
			return true
	return false

func update_direction(input_vector: Vector2) -> void:
	if input_vector == Vector2.ZERO:
		return
	
	if abs(input_vector.x) > abs(input_vector.y):
		last_direction = "right" if input_vector.x > 0 else "left"
	else:
		last_direction = "down" if input_vector.y > 0 else "up"

func play_direction_animation(anim_name: String) -> void:
	anim_sprite.play("%s_%s" % [anim_name, last_direction])

func enable_weapon_collision(value: bool) -> void:
	enemy_attack_area.monitoring = value
