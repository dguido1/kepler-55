extends Control

const STAGE = "Dev Level: 00"

#var scene_blue = "res://environment/scene/GalaxyBlue.tscn"
var game_scene = "res://Scenes/SceneObj/GameScene.tscn"

func _ready():
	$CenterContainer/VBoxContainer/Stage.text = STAGE 
	#+ str(AutoLoad._stage)
	$CenterContainer/VBoxContainer/Name.text = "Welcome to Space Shooter!"
	#AutoLoad._stage_name

func _on_Timer_timeout():
	get_tree().change_scene(game_scene)
