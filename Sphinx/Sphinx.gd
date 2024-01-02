extends KinematicBody2D

var velocity = Vector2()
var xdir = 0
var ydir = 0
var speed = 150

var health = 5
var idle = true
var alive = true
var attacking = false

const BULLET = preload("res://Desert/Sphinx/SphinxProjectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if alive:
		velocity.x=xdir
		velocity.y=ydir
		if idle:
			velocity.x=0
			velocity.y=0
		else:
			#$AnimatedSprite.play("walk")
			if xdir==1:
				$AnimatedSprite.flip_h = false
			elif xdir==-1:
				$AnimatedSprite.flip_h = true
		
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
	if alive:
		$AnimatedSprite.play("walk")
		
func attack():
	if alive:
		$AnimatedSprite.play("attack")
		$attackTimer.start()
		#print("attack")
		var bullet = BULLET.instance()
		bullet.rotation_degrees = global_position.direction_to(Global.player_position).angle()
		get_parent().add_child(bullet)
		bullet.position = $SphinxPosition.global_position
		bullet.velocity = 10 * (global_position.direction_to(Global.player_position))

func die():
	alive=false
	$AnimatedSprite.play("hurt")
	$dieTimer.start()

func _damage():
	$AnimatedSprite.play("hurt")
	health-=1
	if health<=0 and alive:
		die()

func _on_moveTimer_timeout():
	if idle:
		idle=false
		randomDirection()
	else:
		idle=true
	#$attackTimer.start()
	attack()

func _on_dieTimer_timeout():
	queue_free()


func _on_attackTimer_timeout():
	if alive:
		if idle:
			$AnimatedSprite.play("idle")
		else:
			$AnimatedSprite.play("walk")
#		var bullet = BULLET.instance()
#		bullet.rotation_degrees = global_position.direction_to(Global.player_position).angle()
#		get_parent().add_child(bullet)
#		bullet.position = $SphinxPosition.global_position
#		bullet.velocity = 10 * (global_position.direction_to(Global.player_position))
