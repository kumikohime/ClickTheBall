extends Node2D

const Ball = preload("res://scenes/Ball/Ball.tscn")
const Paw = preload("res://scenes/CatPaw/CatPaw.tscn")

@onready var timer = $Timer
@onready var spawn_point = $SpawnPoint
@onready var score_label = $CanvasLayer/MarginContainer/VBoxContainer/Score
@onready var highscore_label = $CanvasLayer/MarginContainer/VBoxContainer/HighScore
@onready var start_button = $CanvasLayer/MarginContainer/Anchor/Start
@onready var game_over: Area2D = $GameOverRegion
@onready var my_ball = $Ball
@onready var paw = $CatPaw


var score = 0: 
	set(v):
		score = v
		score_label.text = "Score %d" % score

var highscore = 0:
	set(v):
		highscore = v
		highscore_label.text = "Highscore %d" % highscore

func _ready():
	#timer.timeout.connect(_on_timer_timeout)
	game_over.body_entered.connect(_on_game_over)
	my_ball.clicked.connect(_on_ball_clicked)
	paw.hide()
	start_button.pressed.connect(start)

func _on_game_over(body):
	#collision layer 2 is player only, no need to check body
	$VoiceOver.shuffle_play()
	if score > highscore:
		highscore = score
	
	await get_tree().create_timer(2).timeout
	start_button.show()
	reset()

func reset():
	my_ball.reset()
	game_over.monitoring = false
	my_ball.freeze = true
	my_ball.linear_velocity = Vector2.ZERO
	my_ball.move_to(spawn_point.global_position)
	
func spawn_ball():
	my_ball = Ball.instantiate()
	my_ball.global_position = spawn_point.global_position
	my_ball.clicked.connect(_on_ball_clicked)
	add_child.bind(my_ball).call_deferred()

func start():
	score = 0

	reset()
	remove_child(my_ball)
	my_ball.freeze = false
	my_ball.input_pickable = true
	add_child(my_ball)
	game_over.monitoring = true
	start_button.hide()

func _on_ball_clicked():
	paw.show()
	paw.global_position = my_ball.global_position
	paw.animate()
	score += 1
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		start()
