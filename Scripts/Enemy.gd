extends KinematicBody2D


export var gravity = 10.0 * Vector2.DOWN
export var launch_speed = 10.0
export var walk_speed = 10.0 
onready var player_to_chase  

var launch_vector = Vector2()
var velocity = Vector2()
var is_launching = false 
var is_attacking = false
var should_attack = false
# Called when the node enters the scene tree for the first time.
func _ready():
	launch_vector = Vector2(-1, -1)
	velocity = Vector2.ZERO
	launch_speed *= 10
	player_to_chase = get_parent().get_node("PlayerController").get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	handle_movement()
	if is_on_floor(): 
		velocity = move_and_slide(velocity, Vector2.DOWN)
	else:	
		velocity = velocity + gravity 
		var collision = move_and_collide(velocity * delta)
		if collision: 
			velocity = move_and_slide(velocity) 	


func handle_movement():
	var direction = position.direction_to(player_to_chase.position)
	if (should_attack): return
	if (direction.x > 0): move_right()
	else: move_left()
	print("direction: ", direction)
	#velocity += (position.direction_to(player_to_chase.position) * walk_speed)


# moves the character left
func move_right(): 
	if not is_attacking: 
		velocity.x += walk_speed

func move_left(): 
	if not is_attacking: 
		velocity.x -= walk_speed


func get_player_direction():
	var player_pos = player_to_chase.position
	var player_direction = (player_pos - position).normalized()
	return player_direction


func _on_hurtbox_entered(_body):
	print("launching")
	velocity = velocity + (launch_vector.normalized() * launch_speed)


func _on_player_enter_attack_area(_body):
	should_attack = true
	print("player eneted my personal space")


func _on_animation_finished(): 
	pass
