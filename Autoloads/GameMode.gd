extends Node

# debug

const startImmediately = true

# gameplay config
const timer : float = 20.0
const basketValue : int = 15

# gamemode vars
var score : int = 0
var playing : bool = false
var gameTimer : float
var timerRunning = false
const BASKET_HOOP = preload("res://Scenes/BasketHoop.tscn")
const PLAYER_BALL = preload("res://Scenes/PlayerBall.tscn")
var playerName : String

# audio
const AUDIO_MANAGER = preload("res://Scenes/AudioManager.tscn")
var AudioManager

# basket hoop vars
var screenSize = Vector2(0,0)
var randomPos = Vector2(0,0)
var margin = Vector2(50,150)
var floorSize = Vector2(0,0)

func _ready():
	Signals.connect("add_points", self, "_add_points")
	_init_audio()
	
func _init_audio():
	AudioManager = AUDIO_MANAGER.instance()
	get_tree().get_root().get_node("MainScene").add_child(AudioManager)
	
func _add_points(points):
	score += points
	Signals.emit_signal("on_score_change", score)
	
func _process(delta):
	if (timerRunning):
		gameTimer -= delta
		Signals.emit_signal("on_timer_change", _formatTimer())
		if gameTimer <= 0:
			timerRunning = false
			gameTimer = 0
			_endGame()
	
func _startGame():
	score = 0
	gameTimer = timer
	timerRunning = true
	playing = true
	_add_points(0)
	_spawnPlayer()
	_spawnBasket()
	Signals.emit_signal("on_game_start")

func _endGame():
	playing = false
	AudioManager.play_audio("res://Audio/Buzzer.wav")
	Signals.emit_signal("submit_score")
	Signals.emit_signal("on_game_end")
	
func _formatTimer():
	var roundedTimer = "%.2f" % (gameTimer)
	var strTimer = str(roundedTimer)
	return strTimer

func _spawnBasket():
	screenSize = Vector2(get_viewport().size.x, get_viewport().size.y - floorSize.y)
	randomPos = Vector2(rand_range(margin.x, screenSize.x - margin.x),rand_range(margin.y, screenSize.y - margin.y))

	var basket = BASKET_HOOP.instance()
	get_tree().get_root().get_node("MainScene").call_deferred("add_child", basket)
	basket.position = randomPos

func _spawnPlayer():
	screenSize = Vector2(get_viewport().size.x, get_viewport().size.y - floorSize.y)
	randomPos = Vector2(rand_range(margin.x, screenSize.x - margin.x),rand_range(margin.y, screenSize.y - margin.y))
	var player = PLAYER_BALL.instance()
	get_tree().get_root().get_node("MainScene").add_child(player)
	player.position = randomPos
