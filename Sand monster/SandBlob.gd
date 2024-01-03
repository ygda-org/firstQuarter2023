extends KinematicBody2D


# Declare member variables here. Examples:


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass


func _on_despawnTimer_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.SPEED = 50


func _on_Area2D_body_exited(body):
	if "Player" in body.name:
		body.SPEED = 200
