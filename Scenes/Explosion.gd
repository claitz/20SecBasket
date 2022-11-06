extends Node2D

onready var particles = $ExplosionParticles

func _ready():
	particles.emitting = true
	GameMode.AudioManager.play_audio("res://Audio/Explosion.wav")

func _process(_delta):
	if !particles.emitting:
		call_deferred("free")
