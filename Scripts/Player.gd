extends KinematicBody2D

export var walk_acceleration = 1.0
export var max_speed = 10.0
export var jump_lift = 10
export var gravity = 10.0
export var friction_coefficient = 0.99

var velocity = Vector2()

# Game mechanics 
var is_attacking = false

onready var sword = get_node("Sword")

# Directions for movement
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var cur_direction = Vector2(DIRECTION_RIGHT, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	cur_direction = Vector2(1, 1)
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (not is_on_floor()): 
		velocity.y += gravity
	else: 
		velocity.x *= friction_coefficient
	velocity = move_and_slide(velocity, Vector2.UP)


func move_left():
	if not is_attacking: 
		set_direction(DIRECTION_LEFT)
		$AnimatedSprite.play("move")
		$Sword.play_walk_animation()
		velocity.x -= walk_acceleration


func move_right(): 
	if not is_attacking: 
		set_direction(DIRECTION_RIGHT)
		$AnimatedSprite.play("move")
		$Sword.play_walk_animation()
		velocity.x += walk_acceleration


func attack():
	if not is_attacking: 
		$AnimatedSprite.play("attack")
		$Sword.play_attack_animation()
		is_attacking = true


func stand_still(): 
	if not is_attacking: 
		$AnimatedSprite.play("stand_still")
		$Sword.play_stand_still_animation()
	velocity.x *= 0.8

func on_hitbox_enetered(): 
	# handle what happens when you are hit 
	print("I've been attacked: ", name)

func set_direction(hor_direction):
	# updates the sprite and returns the new direction
	if (hor_direction == 0): 
		hor_direction = DIRECTION_RIGHT
	# get unit direction 
	var unit_dir = hor_direction / abs(hor_direction)
	# flip the sprite 
	# Update direction
	apply_scale(Vector2(unit_dir * cur_direction.x, 1))
	cur_direction = Vector2(unit_dir, cur_direction.y)


func _on_animation_finished():
	$AnimatedSprite.stop()
	$AnimatedSprite.set_frame(0)
	if (is_attacking): 
		is_attacking=false


func jump(): 
	if not is_attacking: 
		#next_velocity.y -= jump_lift	
		pass
	pass

