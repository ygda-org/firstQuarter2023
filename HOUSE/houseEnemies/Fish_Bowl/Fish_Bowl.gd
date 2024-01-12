extends KinematicBody2D

var velocity = Vector2()
var strength = Vector2()
var move = false


# Called when the node enters the scene tree for the first time.
func _ready():
	print("bruh")
	velocity = Vector2(0,0)
	strength = Vector2(0,0)
	pass # Replace with function body.

func _physics_process(delta):
	if Global.on_head == true:
		position = Global.player_position
	if Global.fish_bowl_dead == true:
		_dead()
	move_and_slide(velocity)
	
	
	
		
func _dead():
	Global.on_head = false
	queue_free()

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		Global.on_head = true
	pass # Replace with function body.
	




func _on_pause_timeout():
	print("yayaya")
	if Global.on_head == false:
		if move == true:
			velocity = position.direction_to(Global.player_position) * 50
			$pause.start()
			move = false
			print("bob")
		else:
			velocity = Vector2.ZERO
			$pause.start()
			move = true
			print("idk")
