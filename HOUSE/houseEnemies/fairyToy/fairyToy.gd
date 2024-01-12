extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"v
var frameLOL = 0
var pPos = Vector2()
var velocity = Vector2()
const FAIRYBULLET = preload("res://HOUSE/houseEnemies/fairyToy/fairyBullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("default")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	frameLOL += 1
	pPos = Global.player_position
	if abs(pPos.x - position.x) < 500 and abs(pPos.y - position.y) < 500:
		velocity = pPos.direction_to(position) * 85
	elif abs(pPos.x - position.x) < 700 and abs(pPos.y - position.y) < 700:
		velocity = Vector2(0,0)
		if frameLOL % 200 == 0:
			_primal_aspid()
	else:
		velocity = Vector2(0,0)
	move_and_slide(velocity)
	
func _primal_aspid():
	var bullet = FAIRYBULLET.instance()
	get_parent().add_child(bullet)
	bullet.position = $attackPos.global_position
	bullet.velocity = 10 * (global_position.direction_to(Global.player_position))
