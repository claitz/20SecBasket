extends Node2D

onready var streamPlayers = get_children()
onready var index = 0

func play_audio(path, offset:int = 0):
	var node = streamPlayers[index]
	
	node.stream = load(path)
	node.play(offset)
	
	index += 1
	
	if index > streamPlayers.size() - 1:
		index = 0

func play_music():
	#play_audio("res://Audio/Final-Hour-isaiah658.ogg", 15)
	print("music")
	
func _ready():
	play_music()
