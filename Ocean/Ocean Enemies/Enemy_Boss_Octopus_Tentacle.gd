extends Area2D

const speed = 50
var velocity = Vector2()
var direction = Vector2()
var l = 0
var ARM = null
var arm = null
var player = null
var dir_to = Vector2()
var rot = 0

#func _ready():
#	for i in get_parent().get_children():
#		if "Player" in i.name:
#			player = i

func _start(length):
	print("start")
	l = length
	if length > 1:
		$ExtendTimer.start()

func _on_ExtendTimer_timeout():
	arm = ARM.instance()
	get_parent().add_child(arm)
	
	arm.position = $Position2D.global_position
	
	dir_to = position.direction_to(player.position)
	if dir_to.x != 0:
		rot = atan(dir_to.y/dir_to.x)
	else:
		if dir_to.y > 0:
			rot = deg2rad(90)
		else:
			rot = deg2rad(270)
	
	#if abs(rotation_degrees-rad2deg(rot)) > 45:
	#	arm.direction = direction
	#	arm.rotation = rotation
	#else:
	arm.direction = dir_to
	arm.rotation = rot
	
	arm.player = player
	arm.ARM = ARM
	arm._start(l-1)

func _damage():
	queue_free()
