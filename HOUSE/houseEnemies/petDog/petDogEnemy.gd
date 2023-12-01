extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2()
var pPos = Vector2()
var health = 5
var alert = false
var start_alert = false
var dash = false
var cooldown = false
var cdcd = false
var running = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if pPos.x < position.x:
		$Anim.flip_h = true
	else:
		$Anim.flip_h = false
	if alert == false:
		if abs(pPos.x - position.x) < 500 and abs(pPos.y - position.y) < 500 and start_alert == false:
			start_alert = true
			$Anim.play("alert")
			$alerting.start()
	pPos = Global.player_position
	if alert == true:
		if abs(pPos.x - position.x) < 500 and abs(pPos.y - position.y) < 500:
			if running == false:
				$Anim.play("run")
			if abs(pPos.y - position.y) > 240 or abs(pPos.x - position.x) > 240:
				if dash == false:
					velocity = position.direction_to(pPos) * Vector2(170,170)
			elif abs(pPos.x - position.x) < 240 and abs(pPos.x - position.x) < 240:
				if dash == false and cooldown == false:
					dash = true
					velocity = position.direction_to(pPos) * Vector2(550,550)
					$dash_dur.start()
				elif cooldown == true:
					velocity = position.direction_to(pPos) * Vector2(170,170)
		elif dash == false:
			running = false
			$Anim.play("default")
			velocity = Vector2(0,0)
	move_and_slide(velocity)

func _damage():
	health = health - 1
	if health < 1:
		queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_alerting_timeout():
	running = true
	$Anim.play("run")
	alert = true


func _on_dash_dur_timeout():
	if cdcd == false:
		$dash_cd.start()
		cdcd = true
	cooldown = true
	dash = false
	velocity = Vector2(0,0)


func _on_dash_cd_timeout():
	cdcd = false
	cooldown = false
