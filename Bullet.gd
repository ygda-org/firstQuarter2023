extends KinematicBody2D

var velocity = Vector2()

func _physics_process(delta):
	move_and_collide(velocity.normalized()*20)
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



	
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		body._dead()
	if not "Player" in body.name:
		queue_free()
	if "Area2D" in body.name:
		queue_free()
	
	pass # Replace with function body.
