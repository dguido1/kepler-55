extends Control

var _screen_size = Vector2(640.0, 360.0)
var MIN_X = 0.0
var MAX_X = 640.0
var MIN_Y = 0.0
var MAX_Y = 360.0

func _ready():
	pass

func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/SceneObj/TransitionScene.tscn")

func _on_Exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
