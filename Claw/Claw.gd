extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Despawn.start()

#func _set_claw_direction
func _process(delta):
	pass


func _on_Despawn_timeout():
	queue_free()


func _on_ClawHitBox_body_entered(body):
	if "Enemy" in body.name:
		body._dead()
