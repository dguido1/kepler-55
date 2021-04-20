extends Control

func _ready():
	pass
	
func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Scenes/SceneObj/GameScene.tscn")


func _on_HomeButton_pressed():
	get_tree().change_scene("res://Scenes/SceneObj/MenuScene.tscn")
