extends KinematicBody2D

var velocity = Vector2()
var speed = 50
var dir = Vector2()
const BUBBLE = preload("Enemy_Seahorse_Bubble.tscn")
var bubble = BUBBLE.instance()
var facing = scale.x
var near_player = false
var detect_range = 500

var health = 4

var player = null

func _ready():
	for i in get_parent().get_children():
		if "Player" in i.name:
			player = i
	if $DetectRange.overlaps_body(player):
		near_player = true
	$AttackTimer.start()

func _physics_process(delta):
	if position.distance_to(player.position) > detect_range:
		return
	
	if dir.x >= 0:
		facing = 1
	else:
		facing = -1
	scale.x = facing
	
	dir = position.direction_to(player.position)
	velocity = speed*dir
	velocity = move_and_slide(velocity)

func _damage():
	health-=1
	if health <= 0:
		queue_free()

func _attack():
	bubble = BUBBLE.instance()
	get_parent().add_child(bubble)
	bubble.position = position
	bubble.position.x += facing*50
	bubble.direction = Vector2(facing,0)
	$AttackTimer.start()

func _on_DetectRange_body_entered(body):
	if "Player" in body.name:
		near_player = true

func _on_DetectRange_body_exited(body):
	if "Player" in body.name:
		near_player = false

func _on_AttackTimer_timeout():
	while !near_player:
		yield(get_tree(), "idle_frame")
	_attack()
