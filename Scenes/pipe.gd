extends StaticBody2D


func _ready():
	scale = Vector2(1.5,1.5)

func set_pos():
	position = Vector2(620, randi_range(150, 500))

