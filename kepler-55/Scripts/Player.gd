extends Area2D
class_name Player

export (int) var move_speed = 300
export (PackedScene) var BulletScene
# export (PackedScene) var Explosion_Scene :PackedScene

#Bullet Additions
var plBullet := preload("res://Scenes/Obj/Bullet.tscn")
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
export var fireDelay: float = 0.15

var _screen_size = Vector2(640.0, 360.0)
var _player_effect = 0
var _can_play = true
var _rng = RandomNumberGenerator.new()
var vel := Vector2(0, 0)

# *************************
# Added 4-19 
var max_hp = 5						# Unit max HP
var curr_hp = max_hp				# Unit current HP

onready var animatedSprite := $AnimatedSprite

onready var fire_particles := $FireParticles
onready var smoke_particles := $SmokeParticles

var weight = 0.1
var asteroid_small_scene := load("res://Scenes/Obj/PlayerSmall.tscn")
var rng = RandomNumberGenerator.new()
var is_exploded = false
var color_idx = 0

var player_piece_sprite00 = load("res://Sprites/playerShip1_damage1.png") 
var player_piece_sprite01 = load("res://Sprites/playerShip1_damage2.png") 
var player_piece_sprite02 = load("res://Sprites/playerShip1_damage3.png") 

var num_enem_kill = 0

var is_game_over = false
var num_met_dest = 0

func _ready():
	_screen_size = get_viewport_rect().size
	fire_particles.emitting = false
	smoke_particles.emitting = false

func _on_attack():
	# Check if shooting
	if Input.is_action_pressed("fire") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		$FireSound.set_pitch_scale(_rng.randf_range(0.95,1.05))
		$FireSound.play()
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _on_move(delta):
	
	var velocity = Vector2()

	var dirVec := Vector2(0, 0)
	
	if Input.is_action_pressed("ui_up"):
		dirVec.y = -1
	elif Input.is_action_pressed("ui_down"):
		dirVec.y = 1
	if Input.is_action_pressed("ui_left"):
		dirVec.x = -1
	elif Input.is_action_pressed("ui_right"):
		dirVec.x = 1
		
	vel = dirVec.normalized() * move_speed
	position += vel * delta
	
func damage(amount: int):
	curr_hp -= amount
	print("Player damaged. " + print_health())

func isDead():
	return curr_hp <= 0

func die():
	
	get_parent().is_game_over = true
	get_parent().get_node("UIHandler").get_node("GameOverTimer").start(2)
	is_game_over = true
	explode()
	print("'Player' has died.\n")

# Function Process
# Run 60 times / sec
func _process(_delta):
	if isDead():			# Check for deathw
		die()
		
	if not isDead() and get_parent().get_node("Player") != null:

		if not is_game_over:
			_restrict_move()
			_on_attack()
			_animate_player()
	
func _physics_process(delta):
	
	if not isDead() and get_parent().get_node("Player") != null:
		_on_move(delta)
		
func _animate_player():
	
	if vel.y < 0:
		animatedSprite.play("Left")			# Up
	elif vel.y > 0:
		animatedSprite.play("Right")		# Down
	else:
		if vel.x > 0:						# Right and not up/down
			animatedSprite.play("Straight")
			fire_particles.emitting = true
			smoke_particles.emitting = true
		else:
			animatedSprite.play("Stop")
			fire_particles.emitting = false
			smoke_particles.emitting = false
		
func _restrict_move():
	position.x = clamp(position.x, 35, _screen_size.x - 35)
	position.y = clamp(position.y, 35, _screen_size.y - 35)

	
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
	asteroid_small.speed = rand_range(2000, 3000)

	randomize()
	var rando = rand_range(.3, scale.x / 2)
	var meteor_scale = Vector2(rando, rando)
	asteroid_small.scale = meteor_scale
	
	if color_idx == 1:
		asteroid_small.get_node("Sprite").texture = player_piece_sprite00
	elif color_idx == 2:
		asteroid_small.get_node("Sprite").texture = player_piece_sprite01
	else:
		asteroid_small.get_node("Sprite").texture = player_piece_sprite02
		
	get_parent().add_child(asteroid_small)

func explode():
	if is_exploded:
		return

	is_exploded = true

	_spawn_asteroid_smalls(4)

	visible = false
	_play_explosion_sound()


func _play_explosion_sound():
	var explosion_sound = AudioStreamPlayer2D.new()
	explosion_sound.stream = load("res://Audio/explosion.wav")
	explosion_sound.pitch_scale = 1
	explosion_sound.position = self.position
	get_parent().add_child(explosion_sound)
	explosion_sound.play(0)
# Debug helper functions
# ************************
# ************************
func print_health():
	return str(curr_hp) + " / " + str(max_hp) + " HP left."

func delete():
	queue_free()

func _on_Player_area_entered(area):
	if not get_parent().is_game_over:
		if area.is_in_group("monster") or area.is_in_group("Meteor"):
			die()
			area.die()
			
		elif area.is_in_group("EnemyBullet"):
			area.delete()
			die()

