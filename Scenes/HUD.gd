extends Control

onready var timerLabel := $BasketballScore/ScoreBoard/TimerLabel
onready var scoreLabel := $BasketballScore/ScoreBoard/ScoreLabel
onready var scoreBoard := $BasketballScore

func _ready():
	Signals.connect("on_game_start", self, "_on_game_start")
	Signals.connect("on_timer_change", self, "_on_timer_change")
	Signals.connect("on_score_change", self, "_on_score_change")
	Signals.connect("on_game_end", self, "_on_game_end")

func _on_timer_change(timer):
	_setTimer(timer)
	
func _on_score_change(score):
	_setScore(score)

func _setTimer(timer):
	timerLabel.set_text(timer)
	
func _setScore(score):
	scoreLabel.set_text(str(score))

func _on_game_start():
	scoreBoard.visible = true

func _on_game_end():
	scoreBoard.visible = false
