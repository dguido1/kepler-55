extends Node2D

export var minSpeed: float = 10
export var maxSpeed: float = 20
export var minRotationRate: float = -20
export var maxRotationRate: float = 20
export var life: int = 20
var speed: float = 0
var rotationRate: float = 0

func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)
	add_to_group("monster")
	
func _physics_process(delta):
		rotation_degrees += rotationRate * delta
		position.x -= speed * delta
	
func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
		print("Monster Deleted")
		queue_free()
