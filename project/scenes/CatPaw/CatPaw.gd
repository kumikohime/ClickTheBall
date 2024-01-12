extends Sprite2D

@export var max_tilt_degrees = 40

@onready var anim_player = $AnimationPlayer

func animate():
	rotation_degrees = randf_range(-max_tilt_degrees, max_tilt_degrees)
	anim_player.stop()
	anim_player.play("fade_out")
