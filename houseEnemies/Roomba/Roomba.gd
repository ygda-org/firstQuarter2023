extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var speed = 50
var tempVelocity = Vector2()
var stopped = false
var ride = false
var turned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Anim.play("evilTurn")
	$turningEvil.start()
	velocity = Vector2(speed,speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass\
func _physics_process(delta):
	if turned == false:
		move_and_slide(velocity)
	



func _on_Bounce_hit_box_body_entered(body):
	if turned == false:
		if stopped == false:
			stopped = true
			tempVelocity = velocity
			velocity = Vector2(0,0)
			$RoombaPause.start()
		else:
			if ride == true:
				body._roomba_ride()
				queue_free()
		


func _on_RoombaPause_timeout():
	stopped = false
	if tempVelocity.x > 0:
		if tempVelocity.y > 0:
			velocity = Vector2(speed,-1*speed)
		else:
			velocity = Vector2(-1*speed,-1*speed)
	else:
		if tempVelocity.y > 0:
			velocity = Vector2(speed,speed)
		else:
			velocity = Vector2(-1*speed,speed)

func _dead():
	$Anim.play("peaceTurn")
	turned = true
	#### !!!! UNCOMMENT THIS LINE TO TURN THE DEFEATED ROOMBA INTO A SPEED BOOST
	#ride = true


func _on_turningEvil_timeout():
	if turned == false:
		$Anim.play("Roaming")
