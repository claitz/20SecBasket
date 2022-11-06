extends Node2D

onready var mainMenu = $MainMenu
onready var leaderboard = $Leaderboard

func _ready():
	Signals.connect("on_game_end", self, "_on_game_end")
	Signals.connect("show_menu", self, "_show_menu")
	
	_show_menu()

func _on_game_end():
	leaderboard.popup()

func _show_menu():
	mainMenu.popup()
