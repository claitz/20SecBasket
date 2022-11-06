tool
extends Control

onready var posLabel = $"ScoreBoard/PositionContainer/Label"
onready var messageLabel = $"ScoreBoard/MessageContainer/TextMessage"
onready var nameBoard = $"NameBoard"
onready var scoreBoard = $"ScoreBoard"

var list_index : int 
var ld_name = "main"
var scoreList : String


func _ready():
	Signals.connect("submit_score", self, "_submit_score")
	SilentWolf.Scores.connect("sw_score_posted", self, "_sw_score_posted")
	SilentWolf.Scores.connect("sw_position_received", self, "_sw_position_received")
	SilentWolf.Scores.connect("sw_scores_received", self, "_sw_scores_received")
	
func render_board(scores):
	if !scores:
		add_no_scores_message()
	else:
		var scoreLen = len(scores)

		for i in range(scoreLen):
			var score = scores[i]
			add_item(score.player_name, str(int(score.score)))
		show_message(scoreList)
	scoreBoard.visible = true

func add_item(player_name, score):
	list_index += 1
	scoreList += str(list_index) + ". " + score + " - " + player_name + "\n"

func add_no_scores_message():
	show_message("No scores yet!")
	
func add_loading_scores_message():
	show_message("Loading scores...")
	
func show_message(message):
	messageLabel.text = message
	$"ScoreBoard/MessageContainer".show()
	messageLabel.margin_top = 135
	
func hide_message():
	$"ScoreBoard/MessageContainer".hide()
	posLabel.hide()

func show_position(scoreid):
	yield(SilentWolf.Scores.get_score_position(scoreid), "sw_position_received")
	
func _submit_score():
	if (GameMode.playerName == ""):
		nameBoard.visible = true
	else:
		_save_score()

func _save_score():
	SilentWolf.Scores.persist_score(GameMode.playerName, GameMode.score)
	
func get_scores():
	scoreBoard.visible = false
	list_index = 0
	scoreList = ""
	var scores = []
	if ld_name in SilentWolf.Scores.leaderboards:
		scores = SilentWolf.Scores.leaderboards[ld_name]
#
#	if len(scores) > 0: 
#		render_board(scores)
#	else:
	add_loading_scores_message()
	yield(SilentWolf.Scores.get_high_scores(10), "sw_scores_received")
	#hide_message()
	render_board(SilentWolf.Scores.scores)

func _on_SaveButton_pressed():
	var name = $"NameBoard/NameContainer/NameEdit".text
	if name == "":
		return
	else:
		nameBoard.visible = false
		GameMode.playerName = name
		_save_score()
		
func _on_CloseButton_pressed():
	self.hide()
	GameMode._startGame()

func _on_MenuButton_pressed():
	self.hide()
	Signals.emit_signal("show_menu")
	
func _sw_score_posted(scoreid):
	show_position(scoreid)
	print("test: " + scoreid)
	
func _sw_position_received(position):
	posLabel.text = "You are #" + str(position) + " with " + str(GameMode.score) + " points"
	posLabel.show()
	print("test: " + str(position))
	get_scores()
