extends Node2D

export (int) var speed = 150
export (Texture) var _texture

var MIN_X = 0.0
var MAX_X = 640.0
var MIN_Y = 0.0
var MAX_Y = 360.0

func _ready():
	$Sprite1.texture = _texture
	$Sprite2.texture = _texture

func _process(delta):
	position.x -= speed * delta
	if global_position.x < -MAX_X:
		position.x = 0

