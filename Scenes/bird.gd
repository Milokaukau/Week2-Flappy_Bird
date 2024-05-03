extends CharacterBody2D

signal collided

const FLAP_SPEED = -400.0
const GRAVITY = 980
var collision
var dead : bool
var dead_audio_played : bool # Here, dead_audio refers to DieAudio & HitAudio
#@onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	# Gravity
	velocity.y += GRAVITY * delta
	
	if !dead:
		if(Input.is_action_just_pressed("flap")):
			velocity.y = FLAP_SPEED
			$SwooshAudio.play()
		
		$AnimatedSprite2D.play("fly")
	else:
		$AnimatedSprite2D.stop()
	
	# If flew out of window, dead
	if (position.y < 0):
		die()
		if !dead_audio_played:
			$DieAudio.play()
			dead_audio_played = true
	
	collision = move_and_collide(velocity * delta)
	
	if collision:
		die()
		collided.emit()
		if !dead_audio_played:
			$HitAudio.play()
			dead_audio_played = true


func respawn():
	dead = false
	dead_audio_played = false
	position = Vector2(126,360)

func die():
	dead = true
	rotation_degrees = 90

func play_point_audio():
	$PointAudio.play()
