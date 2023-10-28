extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")
	$Despawn.start()

#func _set_claw_direction
func _process(delta):
	print("physics")


func _on_Despawn_timeout():
	print("hiiii")
	queue_free()


func _on_ClawHitBox_body_entered(body):
	print("byeee")
	if "EnemyTest" in body.name:
		body._dead()
