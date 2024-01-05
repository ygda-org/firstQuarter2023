extends KinematicBody2D

var velocity = Vector2() 
var speed = 100 
var playerHolder #Stores player position

var animation = "normal"

var health = 2
var alive = true

var decRange = 10 #Range at which it will attempt to charge
var chaRange = 100 
var chaLock = false #Charging or not
var chaDirX = 0 #Charging x dir
var chaDirY = 0 #Charging y dir

func _ready():
	playerHolder = get_parent().get_node("Player") #Stores position
func _physics_process(delta):
	if alive:
		var xDif = playerHolder.global_position.x - self.global_position.x #Distance to player in x axis
		var yDif = playerHolder.global_position.y - self.global_position.y #Distance to player in y axis
		var xDifA = abs(xDif)
		var yDifA = abs(yDif)
		var yPlRel = int(yDif > 0) - int(yDif < 0)#Above or below?
		var xPlRel = int(xDif > 0) - int(xDif < 0)#To the left or right?
		
		if chaLock:
			move(chaDirX,chaDirY,speed) #Charging? then charge
		else:#Bunch of spagetti code that moves the enemy closer to the player in a rigid kinda newyork block style
			$AnimatedSprite.play(animation)
			if xDifA <= decRange or yDifA <= decRange:
				move(xPlRel * int(xDifA > yDifA),yPlRel * int(xDifA < yDifA),speed)
				if xDifA <= decRange and yDifA <= chaRange:
					charge(0, yPlRel)
				elif yDifA <= decRange and xDifA <= chaRange:
					charge(xPlRel, 0)
			else:
				move(xPlRel * int(xDifA < yDifA),yPlRel * int(xDifA > yDifA),speed)
		
		if get_slide_count() > 0:
			for i in get_slide_count():
				if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider._damage()
		velocity = move_and_slide(velocity)	

func move(xDir, yDir, nSpeed):#Moves the enemy in given direction with given speed
	speed = nSpeed
	velocity.x = xDir * speed
	velocity.y = yDir * speed

func charge(cxDir, cyDir):
	#Wind up animation
	chaLock = true#Locks normal movement and only allows charge motion
	chaDirX = cxDir#Locks charge direction
	chaDirY = cyDir#Locks charge direction
	speed = 0
	$TIcharge_windup.start()#Starts a wind up to give the player a chance

func _on_TIcharge_windup_timeout():
	#Charge animation
	speed = 500
	$TIcharge_move.start()

func _on_TIcharge_move_timeout():
	speed = 100
	chaLock = false
	chaDirX = 0
	chaDirY = 0

func _damage():
	health -= 1
	if health == 0:
		_dead()

func _dead():
	alive = false
	animation = "dead"
	$dieTimer.start()

func _on_TIdie_timeout():
	queue_free()
