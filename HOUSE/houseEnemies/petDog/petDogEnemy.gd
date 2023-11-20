extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var pPos = Vector2()
var health = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	pPos = Global.player_position
	if abs(pPos.x - position.x) < 400 and abs(pPos.y - position.y) < 400:
		velocity = position.direction_to(pPos) * Vector2(100,100)
	else:
		velocity = Vector2(0,0)
	move_and_slide(velocity)

func _damage():
	health = health - 1
	if health < 1:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
