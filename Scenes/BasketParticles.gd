extends Node2D

onready var particles = $BasketParticles

func _ready():
	particles.emitting = true

func _process(_delta):
	if !particles.emitting:
		call_deferred("free")
