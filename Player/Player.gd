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
const BULLET = preload("res://Bullet/Bullet.tscn")
var on_head_counter = 10
var dash_lock = false


func _physics_process(delta):
	## CURSOR TRACKING
	Global.player_position = position
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
	## MOVEMENT
	if(Input.is_action_pressed("ui_right") and dash_lock == false):
		velocity.x = 1
		direction = 3
	elif(Input.is_action_pressed("ui_left") and dash_lock == false):
		velocity.x = -1
		direction = 2 
	else: 
		if dash_lock == false:
			velocity.x = 0
	if(Input.is_action_pressed("ui_down") and dash_lock == false):
		velocity.y = 1
		direction = 1
	elif(Input.is_action_pressed("ui_up") and dash_lock == false):
		velocity.y = -1
		direction = 0
	else:
		if dash_lock == false:
			velocity.y = 0	
	## DASH
	if Input.is_action_just_pressed("tab") and dash_lock == false:
		dash_lock = true
		SPEED = 500
		$Dash_Length.start()
	## DIRECTIONS
	if dirList[direction] == "Right" or dirList[direction] == "Left":
		$CollisionPolygon2D.rotation_degrees = 90
	else:
		$CollisionPolygon2D.rotation_degrees = 0
	if(velocity.x != 0 or velocity.y != 0):
		$AnimationPlayer.play("walk" + dirList[direction])
	else:
		$AnimationPlayer.play("idle" + dirList[direction])
	## FISH BOWL
	if Global.on_head == false:
		if Input.is_action_just_pressed("mouse_left") and current_hotbar == 1:
			var claw = CLAW.instance()
			claw_distance = 30*(position.direction_to(mouse_position))
			claw.position = $Attack_Position.global_position + Vector2(claw_distance)
			claw.rotation_degrees = mouse_angle
			get_parent().add_child(claw)
		if Input.is_action_just_pressed("mouse_left") and current_hotbar == 2:
			var bullet = BULLET.instance()
			bullet.rotation_degrees = mouse_angle
			get_parent().add_child(bullet)
			bullet.position = $Attack_Position.global_position
			bullet.velocity = 10 * (position.direction_to(mouse_position))
	if Global.on_head == true:
		if Input.is_action_just_pressed("mouse_left"):
			on_head_counter -=1
			if on_head_counter == 0:
				Global.fish_bowl_dead = true
	## INVENTORY
	if Input.is_action_just_pressed("ui_key_e"):
		if current_hotbar != 2:
			current_hotbar+=1
		else:
			current_hotbar = 1
		
	move_and_slide(velocity * SPEED)
	
	
	

## END OF DASH
func _on_Dash_Length_timeout():
	SPEED = 200
	dash_lock = false


func _dead():
	set_physics_process(false)
	set_physics_process(false)
	$CollisionPolygon2D.set_deferred("disabled",true)
	velocity.x = 0
	velocity.y = 0
	get_tree().change_scene("res://world.tscn")
	Global.health = 3
	
func _damage():
	Global.health -=1
	if Global.health <= 0:
		_dead()
	else:
		$iFrames.start()
		$CollisionPolygon2D.set_deferred("disabled",true)


func _on_iFrames_timeout():
	$CollisionPolygon2D.set_deferred("disabled", false)
	pass # Replace with function body.
