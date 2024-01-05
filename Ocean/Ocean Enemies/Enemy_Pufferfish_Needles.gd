extends Area2D

const speed = 250
var velocity = Vector2()
var direction = Vector2()

func _physics_process(delta):
	velocity = direction*speed*delta
	translate(velocity)

func _damage():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_Pufferfish_Needles_body_entered(body):
	if "Player" in body.name:
		body._damage()
	if not "Enemy_Pufferfish" in body.name:
		queue_free()
