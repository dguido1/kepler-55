extends "res://Scripts/Meteor.gd"


func _on_VisibilityNotifier2D_screen_exited():
	delete()

func delete():
	queue_free() # Replace with function body.
