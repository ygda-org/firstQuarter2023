extends KinematicBody2D

var velocity = Vector2()
var xdirection = 1
var ydirection = 0
var speed = 500

var health = 5
var idle = true
var alive = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if alive:
		
		velocity.x=xdirection
		velocity.y=ydirection
		
		
		if idle:
			xdirection=0
			ydirection=0
			$AnimatedSprite.play("tail")
		elif(xdirection!=0):
			$AnimatedSprite.play("walk")
			if xdirection==1:
				$AnimatedSprite.flip_h = true
			elif xdirection==-1:
				$AnimatedSprite.flip_h = false
		
		#collision
		for i in get_slide_count():
			var coll = get_slide_collision(i).collider
			if coll!=null:
				if "Player" in coll.name:
					coll._damage()
				elif "Bullet" in coll.name:
					_damage()
					
		
		velocity = move_and_slide(velocity*speed)
			
func randomDirection():
	var temp = round(rand_range(1,4))
	xdirection=0
	ydirection=0
	if(temp==1):
		xdirection=1
	elif temp==2:
		xdirection=-1
	elif temp==3:
		ydirection=1
	else:
		ydirection=-1

func die():
	if alive:
		alive=false
		$AnimatedSprite.play("hurt")
		$dieTimer.start()

func _damage():
#	health-=1
#	if health<=0:
#		die()
	die()

func _on_moveTimer_timeout():
#	if !idle:
#		randomDirection()
	if!idle:
		if xdirection+ydirection==0:
			randomDirection()
		elif rand_range(1,5)>2:
			var temp = xdirection
			xdirection = -ydirection
			ydirection=temp


func _on_idleTimer_timeout():
	if idle:
		idle=false
	else:
		idle=true


func _on_dieTimer_timeout():
	queue_free()
