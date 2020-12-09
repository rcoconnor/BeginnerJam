extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Camera2D.position=$Player.position
	handle_input()
	
func update_camera(): 
	var pos = $Player.get_position()
	$Camera2D.set_position(pos)


func handle_input(): 
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	if (left and not right) or (right and not left): 
		if left: 
			$Player.move_left()
		else: 
			$Player.move_right()
	else: $Player.stand_still() 
	
	if(Input.is_action_just_pressed("attack")): 
		$Player.attack()
	elif(Input.is_action_pressed("jump")): 
		$Player.jump()
	
