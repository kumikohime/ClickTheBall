extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]

func _ready():
	_shuffle()
	finished.connect(_shuffle)

func _shuffle():
	if not streams.is_empty():
		var rand_idx = randi_range(0, streams.size() - 1)
		stream = streams[rand_idx]
