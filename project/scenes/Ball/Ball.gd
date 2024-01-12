extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$RigidBody2D.clicked.connect(_on_body_clicked)
	
func _on_body_clicked():
	$AnimationPlayer.play("squish")
