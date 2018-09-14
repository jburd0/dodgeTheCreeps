extends Area2D
signal hit

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

# speed // export allows var to changed in inspector
# how fast the player will move in pixels

export (int) var speed
# screensize of game
var screensize


func _ready():
	screensize = get_viewport_rect().size
	
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hide()

func _process(delta):
	var velocity = Vector2() # Players movement vector
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true
	pass # replace with function body
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	

