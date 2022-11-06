extends StaticBody2D

onready var floorCol := $FloorCollision
onready var sprite := $Court

func _ready():
	sprite.get_rect().size.x = get_viewport().size.x
	GameMode.floorSize = floorCol.shape.extents
