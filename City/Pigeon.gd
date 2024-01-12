extends Sprite


var speed = 150 #set speed to something reasonable. Idk what is reasonable
var target 
var direction = Vector2.ZERO
var enemy_health = 100
var defeat_sound #Do we have a sound for defeat?

func _ready():
	target = get_node("Player") #Add Player node thing

func _process(frame):
	if target:
		direction = (target.global_position - global_position).normalized()
		position += direction * speed * frame

func enemy_body(body):
	if body.name == "Player": 
		body.damage(100) # Add way for player to take damage. How does it work? Whatsound sgood fordamage?

func damage(amount):
	enemy_health -= amount
	if enemy_health <= 0:
	   enemy_defeat() #It should kill itself after hitting player once for big chunk of damage

func enemy_defeat():
	defeat_sound.play()
	queue_free() #i thin kthis should clear enemy

