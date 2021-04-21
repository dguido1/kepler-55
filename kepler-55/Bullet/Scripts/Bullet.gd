extends Area2D

#var pBulletEffect := preload("res://Bullet/BulletEffect.tscn")

export var speed: float = 500

func _physics_process(delta):
	position.x += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	delete()

func delete():
	queue_free()
