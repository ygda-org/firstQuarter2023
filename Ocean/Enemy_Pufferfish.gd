extends KinematicBody2D

var velocity = Vector2()
var speed = 50
var dir = Vector2()
var ready = false
var player = null
var health = 3
var is_damagable = false
var inflated = Vector2(1,1)
var deflated = Vector2(0.75,0.75)
var near_player = false
const NEEDLE = preload("res://Ocean/Enemy_Pufferfish_Needle.tscn")
var needle = NEEDLE.instance()

func _ready():
	$CollisionShape2D.scale = inflated
	for i in get_parent().get_children():
		if "Player" in i.name:
			player = i
	if $Area2D.overlaps_body(player):
		near_player = true
	$AttackTimer.start()

func _physics_process(_delta):
	dir = position.direction_to(player.position)
	velocity = speed*dir
	velocity = move_and_slide(velocity)

func _damage():
	if is_damagable:
		health-=1
		if health <= 0:
			queue_free()
	else:
		is_damagable = true
		$PuffTimer.start()
		$CollisionShape2D.scale = deflated

func _on_PuffTimer_timeout():
	is_damagable = false
	$CollisionShape2D.scale = inflated

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		near_player = true

func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		near_player = false

func _on_AttackTimer_timeout():
	while !near_player:
		yield(get_tree(), "idle_frame")
	_attack()

func _attack():
	var degree = 0
	var radians = 0
	var count = 12
	for i in range(count+1):
		radians = deg2rad(degree)
		needle = NEEDLE.instance()
		get_parent().add_child(needle)
		needle.position = position
		needle.rotation = radians
		needle.direction = Vector2(cos(radians),sin(radians))
		degree = (360/count)*i
	$AttackTimer.start()
