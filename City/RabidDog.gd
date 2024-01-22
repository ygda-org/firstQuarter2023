extends KinematicBody2D

# Properties
var speed = 200  # Adjust the speed as needed
var player
var player_alive = true
var enemy_alive = true
var chaseDistance = 500
var attackDistance = 150
var dashSpeed = 500

func _ready():
	# Find the player node by name
	player = get_node("/root/Node2D/Player")

func _process(delta):
	if enemy_alive:
		if player:
			if player_alive:
			# Calculate the direction vector towards the player
				var distance = global_position.distance_to(player.global_position)
				if distance <= chaseDistance:
					var direction = (player.global_position - global_position).normalized()
					move_and_slide(direction * speed)
					$AnimatedSprite.play("run")
					if distance <= attackDistance:
						$AnimatedSprite.play("attack")
						move_and_slide(direction * dashSpeed)
						if distance == 0:
							player_alive = false
							
			else:
				speed = 0
				dashSpeed = 0

func _dead():
	speed = 0
	speed = 0
	
	enemy_alive = false
	$Hitbox.set_deferred("disabled", true)
	
	print("Enemy Killed!")
	hide()
	set_process(false)
	
	$AnimatedSprite.play("dead")


