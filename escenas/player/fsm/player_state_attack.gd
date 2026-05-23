extends PlayerState
class_name PlayerStateAttack

const WEAPON_ROTATION: Dictionary = {
	"down": 180.0,
	"up": 0.0,
	"left": -90.0,
	"right": 90.0
}

func enter_state() -> void:
	player.play_direction_animation("attack")
	position_weapon()
	player.anim_sprite.animation_finished.connect(_animation_finished)

func exit_state() -> void:
	if player.anim_sprite.animation_finished.is_connected(_animation_finished):
		player.anim_sprite.animation_finished.disconnect(_animation_finished)

func position_weapon() -> void:
	var direction_key: String = player.last_direction
	var marker: Marker2D = player.attack_pos[direction_key]
	player.weapon.global_position = marker.global_position
	player.weapon.rotation_degrees = WEAPON_ROTATION[direction_key]
	player.weapon.show()
	player.enable_weapon_collision(true)


func _animation_finished() -> void:
	player.enable_weapon_collision(false) 
	player.weapon.hide()
	fsm.transition_to("Idle")
