extends KinematicBody2D

var velocity = Vector2()
var xdirection = 1
var ydirection = 0
var speed = 200

var health = 5
var idle = true
var alive = true

const BULLET = preload("res://Desert/Sphinx/SphinxProjectile.tscn")

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
			#$AnimatedSprite.play("tail")
#		elif(xdirection!=0):
			#$AnimatedSprite.play("walk")
			if xdirection==1:
				$AnimatedSprite.flip_h = true
			elif xdirection==-1:
				$AnimatedSprite.flip_h = false
		
		#collision
		for i in get_slide_count():
			var coll = get_slide_collision(i).collider
			if coll!=null:
				if "Player" in coll.name:
					coll._dead()
				elif "Bullet" in coll.name:
					_damage()
					
		
		velocity = move_and_slide(velocity*speed)
			
func randomDirection():
	while xdirection==0&&ydirection==0:
		xdirection=round(rand_range(-1,1))
		ydirection=round(rand_range(-1,1))

func attack():
	var bullet = BULLET.instance()
	bullet.rotation_degrees = global_position.direction_to(Global.player_position).angle()
	get_parent().add_child(bullet)
	bullet.position = $SphinxPosition.global_position
	bullet.velocity = 10 * (global_position.direction_to(Global.player_position))

func die():
	alive=false
	#$AnimatedSprite.play("hurt")
	$dieTimer.start()

func _damage():
#	health-=1
#	if health<=0:
#		die()
	die()

func _on_moveTimer_timeout():
	attack()
	if idle:
		idle=false
		randomDirection()
	else:
		idle=true


func _on_dieTimer_timeout():
	queue_free()
