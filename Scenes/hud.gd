extends CanvasLayer

#func _ready():
#	var s = "%05d" % 5678
#	print(s)
#	print(s[1])
#	$Score_label.display_digits(919)

#func set_label_score(s):
#	$lblScore.text = s

func update_score_label(num):
	$Score_label.display_digits(num)

func display_insruction(display: bool = true):
	$Instruction_container.visible = display

func display_game_over(display: bool = true):
	$Game_over_rect.visible = display
