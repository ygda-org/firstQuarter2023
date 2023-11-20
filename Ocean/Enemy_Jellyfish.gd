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
	$AttackTimer.start()

func _physics_process(_delta):
	can_attack = false
	for i in get_slide_count():
		if "Player" in get_slide_collision(i).collider.name:
			can_attack = true
			break
	
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
	while !can_attack:
		yield(get_tree(), "idle_frame")
	_attack(player)

func _attack(victim):
	victim._damage()
	victim._stun(2)
	$AttackTimer.start()
