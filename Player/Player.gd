extends KinematicBody2D

var SPEED = 200
var velocity = Vector2()
var direction = 0
var CLAW = preload("res://Claw.tscn")
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
	if dirList[direction] == "Right" or dirList[direction] == "Left":
		$CollisionPolygon2D.rotation_degrees = 90
	else:
		$CollisionPolygon2D.rotation_degrees = 0
	if(velocity.x != 0 or velocity.y != 0):	
		$AnimationPlayer.play("walk" + dirList[direction])
	else:
		$AnimationPlayer.play("idle" + dirList[direction])
	if Input.is_action_just_pressed("ui_select"):
		var claw = CLAW.instance()
		if dirList[direction] == "Right":
			claw.position = $Claw_PositionRight.global_position
			claw.rotation_degrees = 0
		elif dirList[direction] == "Left":
			claw.position = $Claw_PositionLeft.global_position
			claw.rotation_degrees = 0
		elif dirList[direction] == "Up":
			claw.position = $Claw_PositionUp.global_position
			claw.rotation_degrees = 90
		else:
			claw.position = $Claw_PositionDown.global_position
			claw.rotation_degrees = 90
		#claw._set_claw_direction(direction)
		get_parent().add_child(claw)
	move_and_slide(velocity * SPEED)
