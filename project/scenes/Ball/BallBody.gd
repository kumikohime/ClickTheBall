extends RigidBody2D

signal clicked

@export var click_velocity = Vector2(0, -500)

func _input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			bounce(event.global_position)
			$AudioStreamShuffler2D.play()
			clicked.emit()

func bounce(pivot = global_position):
	linear_velocity = click_velocity
	var impulse_direction = global_position - pivot
	impulse_direction *= 0.25
	impulse_direction.y = 0
	var final_impulse = impulse_direction
	apply_impulse(final_impulse, global_position)
	$AnimationPlayer.play("squish")
