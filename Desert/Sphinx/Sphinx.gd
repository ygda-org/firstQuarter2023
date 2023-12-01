extends KinematicBody2D

var velocity = Vector2()
var xdir = 0
var ydir = 0
var speed = 100

var health = 5
var idle = true
var alive = true

const BULLET = preload("res://Desert/Sphinx/SphinxProjectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if alive:
		velocity.x=xdir
		velocity.y=ydir
		if idle:
			velocity.x=0
			velocity.y=0
			#$AnimatedSprite.play("tail")
		else:
			#$AnimatedSprite.play("walk")
			if xdir==1:
				$AnimatedSprite.flip_h = true
			elif xdir==-1:
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
	#while xdir==0 && ydir==0:
	xdir=randi()%3-1
	ydir=randi()%3-1
		
func attack():
	if alive:
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
	health-=1
	if health<=0 and alive:
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
