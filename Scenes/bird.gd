extends CharacterBody2D

const FLAP_SPEED = -400.0
const GRAVITY = 980
var game_over : bool = true

func _physics_process(delta):
	
	velocity.y += GRAVITY * delta;
	
	if(Input.is_action_just_pressed("flap")):
		velocity.y = FLAP_SPEED
	
	if !game_over:
		$AnimatedSprite2D.play("fly")
	
	move_and_slide()

func respawn():
	position = Vector2(126,360)
