extends Area2D

export (int) var move_speed = 250
# export (PackedScene) var BulletScene
# export (PackedScene) var Explosion_Scene :PackedScene

var _screen_size = Vector2(640.0, 360.0)
var _player_effect = 0
var _can_play = true

# signal destroy
# signal load_next_step


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
	
func _process(delta):
	
	if _can_play:
		_on_move(delta)
		_restrict_move()
		
func _restrict_move():
	position.x = clamp(position.x, 35, _screen_size.x - 35)
	position.y = clamp(position.y, 35, _screen_size.y - 35)

