extends KinematicBody2D

var SPEED = 200
var velocity = Vector2()
var direction = 0
var CLAW = preload("res://Claw/Claw.tscn")
var dirList = ["Up", "Down", "Left", "Right"]
var mouse_position = Vector2()
var mouse_distance = Vector2()
var mouse_angle = 0
var claw_distance = Vector2()
var current_hotbar = 1
const BULLET = preload("res://Bullet.tscn")

func _physics_process(delta):
	#find the position of mouse and find the angle
	mouse_position = get_global_mouse_position()
	mouse_distance = mouse_position - position
	if mouse_distance.x == 0:
		mouse_distance.x = 0.000001
	if mouse_distance.y == 0:
		mouse_distance.y = 0.000001
	if mouse_distance.x <0:
		mouse_angle = atan(mouse_distance.y/mouse_distance.x)*(180/PI)+180
	else:
		mouse_angle = atan(mouse_distance.y/mouse_distance.x)*(180/PI)
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
	if Input.is_action_just_pressed("mouse_left") and current_hotbar == 1:
		var claw = CLAW.instance()
		#set the angle of the claw to the angle we found, and set the distance of the claw to 60 units away from claw_position
		claw_distance = 30*(position.direction_to(mouse_position))
		claw.position = $Attack_Position.global_position + Vector2(claw_distance)
		claw.rotation_degrees = mouse_angle
		get_parent().add_child(claw)
	if Input.is_action_just_pressed("mouse_left") and current_hotbar == 2:
		var bullet = BULLET.instance()
		Global.bullet_velocity = 10 * (position.direction_to(mouse_position))
		bullet.rotation_degrees = mouse_angle
		get_parent().add_child(bullet)
		bullet.position = $Attack_Position.global_position
	if Input.is_action_pressed("ui_key_e"):
		if current_hotbar != 2:
			current_hotbar+=1
		else:
			current_hotbar = 1
		
	move_and_slide(velocity * SPEED)
	
	
