extends CharacterBody2D
class_name Player

@export var max_health: float = 10.0
@export var max_mana: float = 10.0
@export var move_speed: float = 67.0
@export var damage: float = 10.0
@export var crit_chance: float = 10.0
@export var crit_damage: float = 10.0

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: Node = $HealthComponent
@onready var fsm: FSM =$FSM




@onready var weapon: Node2D = $Weapon
@onready var enemy_attack_area: Area2D = %EnemyAttackArea
@onready var attack_pos: Dictionary = {
	"down": %Down,
	"up": %Up,
	"left": %Left,
	"right": %Right
}

var curr_mana: float = 0.0



var last_direction: String = "down"

func _process(delta: float) -> void:
	fsm.current_state.process_state(delta)


func reset_health() -> void:
	health_component.setup(max_health)


func is_moving() -> bool:
	var move_input = ["move_up","move_down","move_right","move_left"]
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
