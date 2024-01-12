extends AudioStreamPlayer2D

@export var streams: Array[AudioStream]

func _ready():
	_shuffle()

func shuffle_play(from_position: float = 0.0):
	_shuffle()
	play()
	
func _shuffle():
	if not streams.is_empty():
		var rand_idx = randi_range(0, streams.size() - 1)
		stream = streams[rand_idx]
