extends Node2D

const Ball = preload("res://scenes/Ball/Ball.tscn")
const Paw = preload("res://scenes/CatPaw/CatPaw.tscn")

@onready var timer = $Timer
@onready var spawn_point = $SpawnPoint
@onready var score_label = $CanvasLayer/Control/Score
@onready var game_over: Area2D = $GameOverRegion
@onready var my_ball = $Ball
@onready var paw = $CatPaw

var score = 0: 
	set(v):
		score = v
		score_label.text = "Score %d" % score

func _ready():
	#timer.timeout.connect(_on_timer_timeout)
	game_over.body_entered.connect(_on_game_over)
	my_ball.clicked.connect(_on_ball_clicked)
	paw.hide()

func _on_game_over(body):
	#collision layer 2 is player only, no need to check body
	#my_ball.global_position = spawn_point.global_position
	$VoiceOver.play()

func _on_timer_timeout():
	reset()
	
func spawn_ball():
	my_ball.global_position = spawn_point.global_position
	my_ball.clicked.connect(_on_ball_clicked)
	add_child(my_ball)

func reset():
	remove_child(my_ball)
	my_ball.linear_velocity = Vector2.ZERO
	my_ball.global_position = spawn_point.global_position
	add_child(my_ball)

func _on_ball_clicked():
	paw.show()
	paw.global_position = my_ball.global_position
	paw.animate()
	score += 1
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reset()
