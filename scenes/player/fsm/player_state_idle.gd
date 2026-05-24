extends PlayerState
class_name PlayerStateIdle

func enter_state() -> void:
	player.play_direction_animation("idle")

func process_state(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		fsm.transition_to("Attack")
		return
	
	if player.is_moving():
		fsm.transition_to("Walk")
