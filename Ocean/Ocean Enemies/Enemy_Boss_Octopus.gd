extends KinematicBody2D

const ARM = preload("Enemy_Boss_Octopus_Tentacle.tscn")
var arm = ARM.instance()
var player = null
var arm_list = []

func _ready():
	for i in get_parent().get_children():
		if "Player" in i.name:
			player = i

func _damage():
	var degree = 0
	var radians = 0
	var count = 8
	for i in range(count+1):
		radians = deg2rad(degree)
		arm = ARM.instance()
		get_parent().add_child(arm)
		arm.position = position
		arm.direction = Vector2(cos(radians),sin(radians))
		arm.position += 64*arm.direction
		arm.rotation = radians
		#arm.length = 3
		arm.ARM = ARM
		arm.player = player
		arm_list.append(arm)
		arm._start(3)
		degree = (360/count)*i
