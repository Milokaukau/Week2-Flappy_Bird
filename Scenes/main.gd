extends Node

@export var pipe_scene : PackedScene
var pipe
var pipes : Array
var bird
var hud
var score : int
var game_running : bool = false
var game_over : bool = false
const SCROLL_SPEED = 200


func _ready():
	hud = $HUD
	bird = $Bird
	
	new_game()

func new_game():
	score = 0
	game_running = false
	game_over = false
	
	bird.respawn()
	
	get_tree().call_group("pipes", "queue_free")
	pipes.clear()
	
	# Reset score to 0
	hud.update_score_label(score)
	hud.display_game_over(false)
	hud.display_insruction()


func _process(delta):
	if not game_running:
		if(Input.is_action_just_pressed("flap")):
			run_game()
	
	if !game_over && game_running:
		scroll_pipes(delta)
	
	if game_over:
		$PipeGenTimer.stop()
		if(Input.is_action_just_pressed("flap")):
			new_game()


func run_game():
	game_running = true
	hud.display_insruction(false)
	
	# Generate the first pipe then continue generating using timer
	generate_pipe()
	$PipeGenTimer.start()
	
	bird.flap()
	bird.make_flying()



func raise_score():
	score += 1
	bird.play_point_audio()
	hud.update_score_label(score)

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


func _on_bird_died():
	game_over = true
	game_running = false
	hud.display_game_over()
