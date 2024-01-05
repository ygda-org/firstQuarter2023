extends KinematicBody2D

var velocity = Vector2()
func _ready():
	$AnimatedSprite.play("default")
	

func _physics_process(delta):
	move_and_collide(velocity.normalized()*10)
	rotation=velocity.angle()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()	

func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body._damage()
	if not "Enemy_Sphinx" in body.name:
		queue_free()
		if "Enemy" in body.name:
			body._damage()

func _on_Area2D_area_entered(area):
	if "Lizard" in area.name:
		area._damage()
