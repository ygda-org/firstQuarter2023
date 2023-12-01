extends KinematicBody2D

var velocity = Vector2()
func _ready():
	velocity.x = 10

func _physics_process(delta):
	move_and_collide(velocity.normalized()*10)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body._damage()
	if not "Enemy_Sphinx" in body.name:
		queue_free()
		print(body.name)
	
