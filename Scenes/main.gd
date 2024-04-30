extends Node

@export var pipe_scene : PackedScene
var pipe
var pipes : Array
var bird

const SCROLL_SPEED = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	bird = $Bird
	bird.respawn()
	
	generate_pipe()
	$PipeGenTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_pipes(delta)

func generate_pipe():
	pipe = pipe_scene.instantiate()
	pipe.set_pos()
	add_child(pipe)
	pipes.append(pipe)

func _on_pipe_gen_timer_timeout():
	generate_pipe()

func scroll_pipes(delta):
	for pipe in pipes:
		pipe.position.x -= SCROLL_SPEED * delta
