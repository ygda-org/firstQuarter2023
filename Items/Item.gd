extends Node2D

func _ready():
	pass

var is_overlap = false

func _on_Area2D_body_entered(body):
	if(body.name == "Player"):
		is_overlap = true

func _on_Area2D_body_exited(body):
	if(body.name == "Player"):
		is_overlap = false

func _physics_process(delta):
	if(is_overlap and Input.is_action_pressed("ui_key_e")):
		queue_free()
