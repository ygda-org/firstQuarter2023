extends KinematicBody2D

var velocity = Vector2()
var speed = 100
var dir = Vector2()
var ready = false
var player = null
var can_attack = true
var health = 3

func _ready():
	for i in get_parent().get_children():
		if "Player" in i.name:
			player = i
	$MoveTimer.start()

func _physics_process(delta):
	for i in get_slide_count():
		if can_attack and "Player" in get_slide_collision(i).collider.name:
			can_attack = false
			$AttackTimer.start()
	
	if ready == false:
		return
	
	dir = position.direction_to(player.position)
	velocity = speed*dir
	velocity = move_and_slide(velocity)
	
func _on_MoveTimer_timeout():
	ready = true
	$WaitTimer.start()

func _on_WaitTimer_timeout():
	ready = false
	$MoveTimer.start()

func _damage():
	health-=1
	if health <= 0:
		queue_free()

func _on_AttackTimer_timeout():
	for i in get_slide_count():
		if "Player" in get_slide_collision(i).collider.name:
			get_slide_collision(i).collider._damage()
			get_slide_collision(i).collider._stun(2)
	can_attack = true
