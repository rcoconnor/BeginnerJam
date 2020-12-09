extends Node2D


onready var anim = $AnimationPlayer
#signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func play_stand_still_animation(): 
	anim.stop()
	anim.play("stand_still")


func play_attack_animation(): 
	anim.play("attack")


func play_walk_animation(): 
	if anim.current_animation != "move":
		anim.play("move")
		anim.seek(0)


# Called once every animation is finished 
func on_animation_finished(anim_val): 
	if anim_val != "stand_still":
		anim.play("stand_still")
	else: anim.stop()


