extends CharacterBody2D

signal collided

const FLAP_SPEED = -400.0
const GRAVITY = 980
var collision
var dead : bool
#@onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	# Gravity
	velocity.y += GRAVITY * delta
	
	if !dead:
		if(Input.is_action_just_pressed("flap")):
			velocity.y = FLAP_SPEED
		
		$AnimatedSprite2D.play("fly")
	else:
		$AnimatedSprite2D.stop()
	
	# If flew out of window, dead
	if (position.y < 0):
		dead = true
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		collided.emit()
		dead = true

func respawn():
	dead = false
	position = Vector2(126,360)
