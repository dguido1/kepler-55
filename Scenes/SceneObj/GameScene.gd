extends Node2D

onready var ui_handler = get_node("UIHandler")

var meteor_one := preload("res://Scenes/Obj/Meteors/Meteor.tscn")
var meteor_two := preload("res://Scenes/Obj/Meteors/MeteorTwo.tscn")
var meteor_three := preload("res://Scenes/Obj/Meteors/MeteorThree.tscn")
var meteor_four := preload("res://Scenes/Obj/Meteors/MeteorFour.tscn")

export var minRotationRate: float = -20
export var maxRotationRate: float = 20

var x_spawn_pos =  660
var y_spawn_pos =  20	# Will be 20px - 340px
onready var spawn_pos01 := $SpawnPos/SpawnPos
onready var spawn_pos02 := $SpawnPos/SpawnPos2
onready var spawn_pos03 := $SpawnPos/SpawnPos3
onready var spawn_pos04 := $SpawnPos/SpawnPos4
onready var spawn_pos05 := $SpawnPos/SpawnPos5

onready var meteor_spawn_timer := $MeteorSpawnTimer
export var meteor_spawn_delay: float = 3

var enemy_one := preload("res://Scenes/Obj/Monster.tscn")

#export var minRotationRate: float = -20
#export var maxRotationRate: float = 20

onready var enemy_spawn_timer := $EnemySpawnTimer
export var enemy_spawn_delay: float = 3

var enemy_sprite00 = load("res://Sprites/enemy00.png") 
var enemy_sprite01 = load("res://Sprites/enemy01.png") 
var enemy_sprite02 = load("res://Sprites/enemy02.png") 
var enemy_sprite03 = load("res://Sprites/enemy03.png") 

var laser_sprite00 = load("res://Sprites/laser00.png") 
var laser_sprite01 = load("res://Sprites/laser01.png") 
var laser_sprite02 = load("res://Sprites/laser02.png") 
var laser_sprite03 = load("res://Sprites/laser03.png") 

var is_game_over = false

func _ready():
	ui_handler.visible = false

func _process(_delta):
	
	if is_game_over:
		var game_over_timer = ui_handler.get_node("GameOverTimer")

		if game_over_timer.is_stopped():
			var player = get_node("Player")
			var kill_str = ""
			var dest_str = ""
			if player.num_enem_kill > 1 or player.num_enem_kill == 0:
				kill_str = "enemies"
			else:
				kill_str = "enemy"
			if player.num_met_dest > 1 or player.num_met_dest == 0:
				dest_str = "meteors"
			else:
				dest_str = "meteor"
				
			var results_str = "You killed " + str(player.num_enem_kill) + " " + kill_str + " and destroyed " + str(player.num_met_dest) + " " + dest_str + "!" 
			var results_label = ui_handler.get_node("CenterContainer").get_node("VBoxContainer").get_node("ResultsLabel")
			results_label.text = results_str
			ui_handler.visible = true

	else:
		ui_handler.visible = false
	
		if meteor_spawn_timer.is_stopped():				# Add a meteor
			meteor_spawn_timer.start(meteor_spawn_delay)
			_add_meteor()
		
		if enemy_spawn_timer.is_stopped():				# Add an enemy
			enemy_spawn_timer.start(enemy_spawn_delay)
			_add_enemy()
	
func _add_meteor():
	var curr_meteor_idx = randi() % 4 + 1		    # Rand int between 1 and 4
	var curr_meteor_pos_idx = randi() % 5 + 1		# Rand int between 1 and 5
	#print (str(curr_meteor_idx) + " " + str(curr_meteor_pos_idx))
	var curr_meteor_size_idx = randi() % 4 + 1	
	
	if curr_meteor_idx == 1:
		
		var meteorOne := meteor_one.instance()
		
		if curr_meteor_pos_idx == 1:
			meteorOne.global_position = spawn_pos01.global_position
		elif curr_meteor_pos_idx == 2:
			meteorOne.global_position = spawn_pos02.global_position
		elif curr_meteor_pos_idx == 3:
			meteorOne.global_position = spawn_pos03.global_position
		elif curr_meteor_pos_idx == 4:
			meteorOne.global_position = spawn_pos04.global_position
		else:
			meteorOne.global_position = spawn_pos05.global_position
		
		if get_node("Meteor") != null:
			
			randomize()
			var rando = rand_range(0.1, 0.4)
			var meteor_scale = Vector2(rando, rando)
			meteorOne.scale = meteor_scale
		
		get_tree().current_scene.add_child(meteorOne)
			
	elif curr_meteor_idx == 2:
		
		var meteorTwo := meteor_two.instance()
		
		if curr_meteor_pos_idx == 1:
			meteorTwo.global_position = spawn_pos01.global_position
		elif curr_meteor_pos_idx == 2:
			meteorTwo.global_position = spawn_pos02.global_position
		elif curr_meteor_pos_idx == 3:
			meteorTwo.global_position = spawn_pos03.global_position
		elif curr_meteor_pos_idx == 4:
			meteorTwo.global_position = spawn_pos04.global_position
		else:
			meteorTwo.global_position = spawn_pos05.global_position
		
		if get_node("Meteor") != null:
			
			randomize()
			var rando = rand_range(0.1, 0.4)
			var meteor_scale = Vector2(rando, rando)
			meteorTwo.scale = meteor_scale
				
		get_tree().current_scene.add_child(meteorTwo)
		
	elif curr_meteor_idx == 3:
		
		var meteorThree := meteor_three.instance()
		
		if curr_meteor_pos_idx == 1:
			meteorThree.global_position = spawn_pos01.global_position
		elif curr_meteor_pos_idx == 2:
			meteorThree.global_position = spawn_pos02.global_position
		elif curr_meteor_pos_idx == 3:
			meteorThree.global_position = spawn_pos03.global_position
		elif curr_meteor_pos_idx == 4:
			meteorThree.global_position = spawn_pos04.global_position
		else:
			meteorThree.global_position = spawn_pos05.global_position
		
		if get_node("Meteor") != null:
			
			randomize()
			var rando = rand_range(0.1, 0.4)
			var meteor_scale = Vector2(rando, rando)
			meteorThree.scale = meteor_scale
				
		get_tree().current_scene.add_child(meteorThree)
		
	else:
		
		var meteorFour := meteor_four.instance()
		
		if curr_meteor_pos_idx == 1:
			meteorFour.global_position = spawn_pos01.global_position
		elif curr_meteor_pos_idx == 2:
			meteorFour.global_position = spawn_pos02.global_position
		elif curr_meteor_pos_idx == 3:
			meteorFour.global_position = spawn_pos03.global_position
		elif curr_meteor_pos_idx == 4:
			meteorFour.global_position = spawn_pos04.global_position
		else:
			meteorFour.global_position = spawn_pos05.global_position
		
		if get_node("Meteor") != null:
			
			randomize()
			var rando = rand_range(0.1, 0.4)
			var meteor_scale = Vector2(rando, rando)
			meteorFour.scale = meteor_scale
				
		get_tree().current_scene.add_child(meteorFour)

func _add_enemy():
	var curr_enemy_pos_idx = randi() % 5 + 1		# Rand int between 1 and 5
	var curr_enemy_clr_idx = randi() % 4 + 1		# Rand int between 1 and 5
	var curr_enemy_size_idx = randi() % 4 + 1		# Rand int between 1 and 5

	var enemyOne := enemy_one.instance()
	var enemySprite = enemyOne.get_node("Sprite")
	#var enemyLazerSprite = enemySprite.get_node("Laser")
	enemyOne.color_idx = curr_enemy_clr_idx					# Used for coloring explosion
	
	if curr_enemy_clr_idx == 1:
		enemySprite.texture = enemy_sprite00
		#enemyLazerSprite.texture = laser_sprite00
	elif curr_enemy_clr_idx == 2:
		enemySprite.texture = enemy_sprite01
		#enemyLazerSprite.texture = laser_sprite01
	elif curr_enemy_clr_idx == 3:
		enemySprite.texture = enemy_sprite02
		#enemyLazerSprite.texture = laser_sprite02
	else:
		enemySprite.texture = enemy_sprite03
		#enemyLazerSprite.texture = laser_sprite03
	
	if get_node("Monster") != null:
		randomize()
		var rando = rand_range(0.4, 1)
		var meteor_scale = Vector2(rando, rando)
		enemyOne.scale = meteor_scale

	if curr_enemy_pos_idx == 1:
		enemyOne.global_position = spawn_pos01.global_position
	elif curr_enemy_pos_idx == 2:
		enemyOne.global_position = spawn_pos02.global_position
	elif curr_enemy_pos_idx == 3:
		enemyOne.global_position = spawn_pos03.global_position
	elif curr_enemy_pos_idx == 4:
		enemyOne.global_position = spawn_pos04.global_position
	else:
		enemyOne.global_position = spawn_pos05.global_position
		
	get_tree().current_scene.add_child(enemyOne)
