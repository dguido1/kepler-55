extends Area2D
class_name Player

export (int) var move_speed = 250
export (PackedScene) var BulletScene
# export (PackedScene) var Explosion_Scene :PackedScene

#Bullet Additions
var plBullet := preload("res://Bullet/Scenes/Bullet.tscn")
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
export var fireDelay: float = 0.1

var _screen_size = Vector2(640.0, 360.0)
var _player_effect = 0
var _can_play = true

# signal destroy
# signal load_next_step

# 1. Start
# Once when the object is created
func _ready():
	_screen_size = get_viewport_rect().size

func _on_attack():
	# Check if shooting
	if Input.is_action_pressed("fire") and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		for child in firingPositions.get_children():
			var bullet := plBullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

func _on_move(delta):
	
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		
	position +=  velocity * move_speed * delta
	
# 2. Update
# 60 Times per second
func _process(delta):
	if _can_play:
		_on_move(delta)
		_restrict_move()
		_on_attack()
		
func _restrict_move():
	position.x = clamp(position.x, 35, _screen_size.x - 35)
	position.y = clamp(position.y, 35, _screen_size.y - 35)

