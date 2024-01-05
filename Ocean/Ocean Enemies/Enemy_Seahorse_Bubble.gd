extends Area2D

var og_pos = global_position
const speed = 200
var velocity = Vector2()
var direction = Vector2()

func _physics_process(delta):
	#if abs(position) > 50:
	#	return
	#print(-clamp(pow((global_position.x-og_pos.x)/100,2),0,2))
	direction.y = -clamp(pow((global_position.x-og_pos.x),2),0,2)
	velocity = direction*speed*delta
	translate(velocity)

func _damage():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Enemy_Seahorse_Bubble_body_entered(body):
	if "Player" in body.name:
		body._damage()
	if not "Enemy_Seahorse" in body.name:
		queue_free()
