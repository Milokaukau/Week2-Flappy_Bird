extends CharacterBody2D

signal died

const FLAP_SPEED = -400.0
const GRAVITY = 980
const MAX_VEL = 600
var collision
var flying: bool
var dead : bool
var dead_audio_played : bool # Here, dead_audio refers to DieAudio & HitAudio
#@onready var screen_size = get_viewport_rect().size

func _physics_process(delta):
	
	# Gravity.
	velocity.y += GRAVITY * delta
	
	# When the game is running.
	if flying:
		if not dead:
			# Check for input and flap the bird.
			if(Input.is_action_just_pressed("flap")):
				flap()
			
			# If flew out of window, dead.
			if (position.y < 0):
				die()
				if !dead_audio_played:
					$DieAudio.play()
					dead_audio_played = true
			
			# If collided, dead.
			if collision:
				print(collision.get_collider())
				die()
				if !dead_audio_played:
					$HitAudio.play()
					dead_audio_played = true
		
		# Save the collision information, if there's any.
		collision = move_and_collide(velocity * delta)
	
	# Keep the animation playing until it dies.
	if not dead:
		$AnimatedSprite2D.play("fly")
	else:
		$AnimatedSprite2D.stop()

func flap():
	velocity.y = FLAP_SPEED
	$SwooshAudio.play()

func make_flying(fly: bool = true):
	flying = fly

func respawn():
	collision = null
	dead = false
	make_flying(false)
	dead_audio_played = false
	position = Vector2(126,360)
	rotation = 0

func die():
	dead = true
	died.emit()
	rotation_degrees = 90

func play_point_audio():
	$PointAudio.play()
