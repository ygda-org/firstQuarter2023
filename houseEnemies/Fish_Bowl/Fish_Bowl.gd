extends Node2D





# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Global.on_head == true:
		position = Global.player_position
	if Global.fish_bowl_dead == true:
		_dead()
func _dead():
	Global.on_head = false
	queue_free()


	



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		Global.on_head = true
	pass # Replace with function body.
