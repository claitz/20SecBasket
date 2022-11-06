extends RigidBody2D

# movement
var speed : int = 450
var jumpForce : int = -600
var gravity : int = 800
var rotSpeed : int = 1
var mouseMulti : int = 1000

var velocity : Vector2 = Vector2()

# references
onready var sprite : Sprite = get_node("Sprite")
onready var particles = preload("res://Scenes/Explosion.tscn")

func _ready():
	Signals.connect("on_game_end", self, "_on_game_end")

func _physics_process(_delta):
	_move()

func _move():
	if GameMode.playing:
		# movement inputs
#		if Input.is_action_just_pressed("move_left"):
#			#sprite.rotate(rotSpeed)
#			apply_torque_impulse(rotSpeed)
#			apply_central_impulse(Vector2(-speed,0))
#			Signals.emit_signal("on_player_input")
#
#		if Input.is_action_just_pressed("move_right"):
#			apply_torque_impulse(-rotSpeed)
#			#sprite.rotate(-rotSpeed)
#			apply_central_impulse(Vector2(speed,0))
#			Signals.emit_signal("on_player_input")
#
#		if Input.is_action_just_pressed("jump"):
#			apply_central_impulse(Vector2(0, jumpForce))
#			Signals.emit_signal("on_player_input")
		if Input.is_action_just_pressed("move_right"):
			GameMode.score += 50
		if Input.is_action_just_pressed("move_left"):
			GameMode.gameTimer -= 5.0
			
		if Input.is_action_just_pressed("mouseMove"):
			var direction = (get_viewport().get_mouse_position() - self.position).normalized()
			apply_central_impulse(direction * mouseMulti)
			Signals.emit_signal("on_player_input")

func _on_game_end():
	var explosion = particles.instance()
	get_tree().get_root().get_node("MainScene").add_child(explosion)
	explosion.position = self.position
	call_deferred("free")
