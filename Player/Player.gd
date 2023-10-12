extends KinematicBody2D

var SPEED = 200
var velocity = Vector2()
var direction = 0
var dirList = ["Up", "Down", "Left", "Right"]

func _physics_process(delta):
	if(Input.is_action_pressed("ui_right")):
		velocity.x = 1
		direction = 3
	elif(Input.is_action_pressed("ui_left")):
		velocity.x = -1
		direction = 2 
	else: 
		velocity.x = 0
	if(Input.is_action_pressed("ui_down")):
		velocity.y = 1
		direction = 1
	elif(Input.is_action_pressed("ui_up")):
		velocity.y = -1
		direction = 0
	else:
		velocity.y = 0	
	if(velocity.x != 0 or velocity.y != 0):	
		$AnimationPlayer.play("walk" + dirList[direction])
	else:
		$AnimationPlayer.play("idle" + dirList[direction])
	move_and_slide(velocity * SPEED)
