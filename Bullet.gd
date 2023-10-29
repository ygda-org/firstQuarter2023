extends Area2D


func _physics_process(delta):
	translate(Global.bullet_velocity)
	pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Bullet_body_entered(body):
	if "EnemyTest" in body.name:
		body._dead()
	if not "Player" in body.name:
		queue_free()
	
	pass # Replace with function body.
