extends KinematicBody2D


export var gravity = 10.0 * Vector2.DOWN
export var launch_speed = 10.0

var launch_vector = Vector2()
var velocity = Vector2()
var is_launching = false 
# Called when the node enters the scene tree for the first time.
func _ready():
	launch_vector = Vector2(-1, -1)
	velocity = Vector2.ZERO
	launch_speed *= 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _physics_process(delta):
	if is_on_floor(): 
		velocity = move_and_slide(velocity, Vector2.DOWN)
	else:	
		velocity = velocity + gravity 
		var collision = move_and_collide(velocity * delta)
		if collision: 
			velocity = move_and_slide(velocity) 	


func _on_hurtbox_entered(_body):
	print("launching")
	velocity = velocity + (launch_vector.normalized() * launch_speed)


func _on_animation_finished(): 
	pass
