extends KinematicBody2D

var velocity = Vector2()
var xdir = 0
var ydir = 0
var speed = 100

var health = 10
var idle = true
var alive = true
var attacking = false

const BLOB = preload("res://Desert/Sand monster/SandBlob.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if alive:
		
		if global_position.distance_to(Global.player_position)<50:
			idle=true
			if !attacking:
				$attackTimer.start()
				attacking=true
				print("attack")
		else:
			idle=false
				
		velocity.x=xdir
		velocity.y=ydir
		if idle:
			$AnimatedSprite.stop()
			velocity.x=0
			velocity.y=0
		else:
			$AnimatedSprite.play("default")
			if xdir==1:
				$AnimatedSprite.flip_h = true
			elif xdir==-1:
				$AnimatedSprite.flip_h = false
		
		#collision
		for i in get_slide_count():
			var coll = get_slide_collision(i).collider
			if coll!=null:
				if "Player" in coll.name:
					coll._damage()
				elif "Bullet" in coll.name:
					_damage()
					
		if !idle:
			velocity = move_and_slide(speed*(global_position.direction_to(Global.player_position)))

func attack():
	if alive:
		attacking=false
		var blob = BLOB.instance()
		get_parent().add_child(blob)
		blob.position = position
		blob.position.x += rand_range(-50,50)
		blob.position.y += rand_range(-50,50)
func move():
	if idle:
		idle=false
	else:
		idle=true		


func die():
	alive=false
	#$AnimatedSprite.play("hurt")
	#$dieTimer.start()
	queue_free()

func _damage():
	health-=1
	if health<=0 and alive:
		die()

func _on_dieTimer_timeout():
	queue_free()
func _on_Area2D_body_entered(body):
	if "Bullet" in body.name or "Claw" in body.name:
		_damage()
func _on_attackTimer_timeout():
	attack()
func _on_moveTimer_timeout():
	move()
