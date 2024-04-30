extends StaticBody2D

signal scored
var recorded_scored : bool = false

func _ready():
	scale = Vector2(1.5,1.5)

func set_pos():
	position = Vector2(620, randi_range(150, 500))



func _on_area_2d_body_entered(body):
	if !recorded_scored and body is CharacterBody2D:
		scored.emit()
		recorded_scored = true
