extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var speed = 50
var tempVelocity = Vector2()
var stopped = false

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2(speed,speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass\
func _physics_process(delta):
	move_and_slide(velocity)
	if get_slide_count()  > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider._damage()



func _on_Bounce_hit_box_body_entered(body):
	if stopped == false:
		stopped = true
		tempVelocity = velocity
		velocity = Vector2(0,0)
		$RoombaPause.start()
		


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
	queue_free()
	
	

