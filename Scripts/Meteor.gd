extends Area2D

export var minSpeed: float = 100
export var maxSpeed: float = 350
export var minRotationRate: float = -180
export var maxRotationRate: float = 180

export var life: int = 20

var speed:float = 0
var rotationRate: float = 0
var playerInArea: Player = null


# *************************
# Added 4-19 
var max_hp = 5						# Unit max HP
var curr_hp = max_hp				# Unit current HP
var vel := Vector2(0, 0)
var curr_dir := Vector2(0, 0)
onready var new_dir_timer := $NewDirTimer
export var dir_delay: float = 5

# Explode
var asteroid_small_scene := load("res://Scenes/Obj/Meteors/MeteorSmall.tscn")
var rng = RandomNumberGenerator.new()
var is_exploded = false

func _ready():
	curr_dir = _get_rand_left_dir()
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)

# Function Process
# Run 60 times / sec
func _process(_delta):
	if isDead():			# Check for death
		die()

func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	vel = curr_dir * speed
	position += vel * delta

func isDead():
	return curr_hp <= 0

func die():
	if curr_hp != 0:
		curr_hp = 0
		
	explode()
	
func damage(amount: int):
	curr_hp -= amount
	print("Meteor damaged. " + print_health())
	
func delete():
	queue_free()
		
func _get_rand_left_dir():
	
	var dirVec := Vector2(0, 0)
	
	var current_direction= randi() % 3 + 1		    # Rand int between 1 and 3
	
	if current_direction == 1:
		# Up and left
		dirVec.x = -1
		dirVec.y = -1
	elif current_direction == 2:
		# Left
		dirVec.x = -1
		dirVec.y = 0
	else:
		# Down and left
		dirVec.x = -1
		dirVec.y = 1
	
	return dirVec
		
func _get_all_rand_dir():
	
	var dirVec := Vector2(0, 0)
	
	var current_direction= randi() % 3 + 1		    # Rand int between 1 and 3
	
	if current_direction == 0:				# Up
		dirVec.x = 0
		dirVec.y = -1
	elif current_direction == 1:			# Up and right
		dirVec.x = 1
		dirVec.y = -1
	elif current_direction == 2:			# Right
		dirVec.x = 1
		dirVec.y = 0
	elif current_direction == 3:			# Down and right
		dirVec.x = 1
		dirVec.y = 1
	elif current_direction == 4:			# Down
		dirVec.x = 0
		dirVec.y = 1
	elif current_direction == 5:			# Down and left
		dirVec.x = -1
		dirVec.y = 1
	elif current_direction == 6:			# Left
		dirVec.x = -1
		dirVec.y = 0
	else:									# Up and left
		dirVec.x = -1
		dirVec.y = -1
		
	return dirVec
	
func _spawn_asteroid_smalls(num):
	for i in range(num):
		_spawn_asteroid_small()
		
func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	asteroid_small.curr_dir = _get_all_rand_dir()
	#asteroid_small.speed = rand_range(2000, 3000)f
	randomize()
	var rando = rand_range(0.05, 0.1)
	var meteor_scale = Vector2(rando, rando)
	asteroid_small.scale = meteor_scale
	get_parent().add_child(asteroid_small)

func _randomize_trajectory(asteroid):
	# random spin
	asteroid.speed = rand_range(300, 500)

func explode():
	if is_exploded:
		return

	_play_explosion_sound()
	is_exploded = true

	_spawn_asteroid_smalls(4)

	get_parent().remove_child(self)
	queue_free()

func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://Audio/explosion.wav")
	explosion_sound.pitch_scale = 1
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)

func print_health():
	return str(curr_hp) + " / " + str(max_hp) + " HP left."

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	delete()

func _on_Meteor_area_entered(area):
	if area.is_in_group("bullet"):
		area.delete()
		damage(1)
