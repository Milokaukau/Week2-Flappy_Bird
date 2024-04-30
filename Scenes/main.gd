extends Node

@export var pipe_scene : PackedScene
var pipe
var pipes : Array
var bird
var hud
var score : int
var game_over : bool = false
const SCROLL_SPEED = 200


func _ready():
	score = 0
	hud = $HUD
	bird = $Bird
	
	bird.respawn()
	
	generate_pipe()
	$PipeGenTimer.start()


func _process(delta):
	if !game_over:
		scroll_pipes(delta)

func raise_score():
	score += 1
	hud.set_label_score(str(score))

func generate_pipe():
	pipe = pipe_scene.instantiate()
	pipe.set_pos()
	add_child(pipe)
	pipe.connect("scored", raise_score)
	pipes.append(pipe)

func _on_pipe_gen_timer_timeout():
	generate_pipe()

func scroll_pipes(delta):
	for pipe in pipes:
		pipe.position.x -= SCROLL_SPEED * delta


func _on_bird_collided():
	game_over = true
