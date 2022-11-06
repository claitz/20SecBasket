extends StaticBody2D

var basketValue : int = 0
var bounceForce : int = 1

onready var ringCollision := $RingCollision
onready var valueLabel := $ValueLabel
onready var particles = preload("res://Scenes/BasketParticles.tscn")

func _ready():
	Signals.connect("on_game_end", self, "_on_game_end")
	Signals.connect("on_player_input", self, "_on_player_input")
	basketValue = GameMode.basketValue
	_update_value_label()

func _on_Area2D_body_entered(body):
	if (body.name == "PlayerBall"):
		if body.linear_velocity.y > 1: # needs to be 1 instead of 0 to account for some residual velocity
			_add_points(basketValue)
			_spawn_particles()
			GameMode.AudioManager.play_audio("res://Audio/Net.wav")
			GameMode._spawnBasket()
			call_deferred("free")
		else:
			body.apply_central_impulse(-body.linear_velocity * bounceForce)

func _add_points(points):
	Signals.emit_signal("add_points", points)
	
func _on_game_end():
	call_deferred("free")
	
func _on_player_input():
	basketValue -= 1
	if basketValue < 1:
		basketValue = 1
	_update_value_label()

func _update_value_label():
	valueLabel.text = str(basketValue)

func _spawn_particles():
	var basketParticles = particles.instance()
	get_tree().get_root().get_node("MainScene").call_deferred("add_child", basketParticles)
	basketParticles.position = self.position
