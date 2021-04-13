extends Area2D

#var pBulletEffect := preload("res://Bullet/BulletEffect.tscn")

export var speed: float = 500

func _physics_process(delta):
	position.x += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	print("bullet deleted")
	queue_free()
	

func _on_Bullet_area_entered(area):
	if area.is_in_group("monster"):
		area.damage(1)
		queue_free()
		#var bulletEffect := pBulletEffect.instance()
		#bulletEffect.position = position
		#get_parent().add_child(bulletEffect)
