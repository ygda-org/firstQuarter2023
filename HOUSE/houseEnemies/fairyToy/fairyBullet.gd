extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("default")
	$timeOut.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	move_and_collide(velocity.normalized()*12)


func _on_Area2D_body_entered(body):
	if 'ayer' in body.name:
		body._damage()
		queue_free()

func _on_timeOut_timeout():
	queue_free()
