extends KinematicBody2D

var velocity = Vector2(1,1)

func _ready():
	$anim.play("default")
	$timeOut.start()


func _physics_process(delta):
	move_and_collide(velocity.normalized()*12)


func _on_Area2D_body_entered(body):
	if 'ayer' in body.name:
		body._damage()
		queue_free()

func _on_timeOut_timeout():
	queue_free()
