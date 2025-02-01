extends RigidBody2D

signal clicked

@export var click_velocity = Vector2(0, -500)
@export var base_grav_scale = 0.35
@export var incremental_grav_factor = 1.05

var _target_position = Vector2()
var _reset_state = false

func _input_event(viewport, event: InputEvent, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			bounce(event.global_position)
			$AudioStreamShuffler2D.shuffle_play()
			clicked.emit()

func bounce(pivot = global_position):
	linear_velocity = click_velocity * sqrt(gravity_scale)

	var impulse_direction = global_position - pivot
	impulse_direction *= 0.25
	impulse_direction.y = 0
	var final_impulse = impulse_direction
	apply_impulse(final_impulse * gravity_scale, global_position)
	$AnimationPlayer.play("squish")
	gravity_scale *= incremental_grav_factor


func _integrate_forces(state):
	if _reset_state:
		state.transform = Transform2D(0.0, _target_position)
		_reset_state = false

func move_to(target_position: Vector2):
	_target_position = target_position;
	_reset_state = true;

func reset():
	gravity_scale = base_grav_scale
