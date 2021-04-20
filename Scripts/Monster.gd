extends Node2D

"""
***********************************************************************
  Project:    Keplar 55 -- Programming Project
   School:    California State University, Fullerton
   Course:    CPSC-254
	 Term:    Spring 2021
 
  Authors:
		   1. David Guido       dguido1@csu.fullerton.edu
		   2. Eric Corona		ecorona9@csu.fullerton.edu
		   3. Quyen Tsai        
***********************************************************************
"""
"""
		   Ideas for enemy AI
	************************************
 		1. random speed ==> awesome
		2. random direction 
		3. random time to be given a new direction, assigned each time a 
		   new random direction is assigned.
			
			i.e. Monster gets assigned a vector2 direction & a new direction 
				 timer. The timer is a float value of say 7.3 seconds which is 
				 how long monster has to wait for a new vector 2 direction.
				
				 This makes the enemies seem alot more automated than they
				 really are.
 
"""

export var minSpeed: float = 50
export var maxSpeed: float = 150
export var minRotationRate: float = -20
export var maxRotationRate: float = 20
export var life: int = 20
export (PackedScene) var BulletScene
# export (PackedScene) var Explosion_Scene :PackedScene

#Bullet Additions
var plBullet := preload("res://Bullet/Scenes/EnemyBullet.tscn")
onready var firingPosition := $Sprite/FiringPosition
onready var fireDelayTimer := $FireDelayTimer
export var fireDelay: float =3

var speed: float = 100
var rotationRate: float = 0

# *************************
# Added 4-19 
var max_hp = 5						# Unit max HP
var curr_hp = max_hp				# Unit current HP
var vel := Vector2(0, 0)
var curr_dir := Vector2(0, 0)
onready var new_dir_timer := $NewDirTimer
export var dir_delay: float = 5
var player_pos = Vector2(0, 0)


var weight = 0.1
var asteroid_small_scene := load("res://Scenes/Obj/MonsterSmall.tscn")
var rng = RandomNumberGenerator.new()
var is_exploded = false
var color_idx = 0

var enemy_piece_sprite00 = load("res://Sprites/enemy_piece00.png") 
var enemy_piece_sprite01 = load("res://Sprites/enemy_piece01.png") 
var enemy_piece_sprite02 = load("res://Sprites/enemy_piece02.png") 
var enemy_piece_sprite03 = load("res://Sprites/enemy_piece03.png") 

var enemy_bullet00 = load("res://Sprites/laser00.png") 
var enemy_bullet01 = load("res://Sprites/laser01.png") 
var enemy_bullet02 = load("res://Sprites/laser02.png") 
var enemy_bullet03 = load("res://Sprites/laser03.png") 

var _rng = RandomNumberGenerator.new()

func _ready():
	speed = 200
	#rotationRate = rand_range(minRotationRate, maxRotationRate)

# Function Process
# Run 60 times / sec
func _process(_delta):
	if isDead():			# Check for death
		die()
	else:
		# Check if shooting
		if fireDelayTimer.is_stopped():
			fireDelayTimer.start(fireDelay)
			$FireSound.set_pitch_scale(_rng.randf_range(0.95,1.05))
			$FireSound.play()
			var bullet := plBullet.instance()
			bullet.global_position = firingPosition.global_position
			bullet.global_rotation = firingPosition.global_rotation

			if color_idx == 1:
				bullet.get_node("Sprite").texture = enemy_bullet00
			elif color_idx == 2:
				bullet.get_node("Sprite").texture = enemy_bullet01
			elif color_idx == 3:
				bullet.get_node("Sprite").texture = enemy_bullet02
			else:
				bullet.get_node("Sprite").texture = enemy_bullet03
			
			bullet.scale = scale
			get_tree().current_scene.add_child(bullet)
	
func _physics_process(delta):
	if not isDead():
		move(delta)	
	
func isDead():
	return curr_hp <= 0

func die():
	if curr_hp != 0:
		curr_hp = 0
		
	explode()
	print("'Monster' has died.\n")

func setrotation(new_transform):
	# apply tweened x-vector of basis
	self.transform.x = new_transform

	# make x and y orthogonal and normalized
	self.transform = self.transform.orthonormalized()
	
func move(delta):
	
	if get_parent().get_node("Player") != null:
		
		var player = get_parent().get_node("Player")
		var angle_to_player = get_angle_to(player.global_position)
		vel.x = cos(angle_to_player)
		vel.y = sin(angle_to_player)
		global_position += vel * speed * delta
		
		var enemy_sprite = get_node("Sprite")
		var to_player = enemy_sprite.global_position - player.global_position
		var offset = 0#-PI / 2
		var rotation_to_player = to_player.angle() + offset
		
		enemy_sprite.rotation = lerp_angle(enemy_sprite.rotation, rotation_to_player, .5)

		#var enemy_lazer = get_node("Sprite").get_node("Laser")
		
		#if is_player_close(player.global_position):
			#enemy_lazer.visible = true
		#else:
			#enemy_lazer.visible = false
	else:
		vel = _get_all_rand_dir()
		speed = 100
		
	
func is_player_close(player_pos):
	
	var xDist = abs(global_position.x - player_pos.x)
	var yDist = abs(global_position.y - player_pos.y)
		
	return xDist < 75 or yDist < 75
	
func lerp_angle(from, to, weight):
	return from + short_angle_dist(from, to) * weight

func short_angle_dist(from, to):
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference	
		
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
	
func damage(amount: int):
	curr_hp -= amount
	print("Monster damaged. " + print_health())

func _spawn_asteroid_smalls(num):
	for i in range(num):
		_spawn_asteroid_small()
		
func _spawn_asteroid_small():
	var asteroid_small = asteroid_small_scene.instance()
	asteroid_small.position = self.position
	asteroid_small.curr_dir = _get_all_rand_dir()
	asteroid_small.speed = rand_range(2000, 3000)
	asteroid_small.scale = scale

	randomize()
	var rando = rand_range(scale.x - (scale.x / 2), scale.x)
	var meteor_scale = Vector2(rando, rando)
	asteroid_small.scale = meteor_scale
	
	if color_idx == 1:
		asteroid_small.get_node("Sprite").texture = enemy_piece_sprite00
	elif color_idx == 2:
		asteroid_small.get_node("Sprite").texture = enemy_piece_sprite01
	elif color_idx == 3:
		asteroid_small.get_node("Sprite").texture = enemy_piece_sprite02
	else:
		asteroid_small.get_node("Sprite").texture = enemy_piece_sprite03
		
	get_parent().add_child(asteroid_small)


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

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	delete()
	
func delete():
	queue_free()

# Debug helper functions
# ************************
# ************************
func print_health():
	return str(curr_hp) + " / " + str(max_hp) + " HP left."

func _on_Monster_area_entered(area):
	if area.is_in_group("bullet"):
		area.delete()
		damage(1)
