extends HBoxContainer

var digit_coords = {
	0: Vector2(0, 0),
	1: Vector2(24, 0),
	2: Vector2(40, 0),
	3: Vector2(64, 0),
	4: Vector2(88, 0),
	5: Vector2(112, 0),
	6: Vector2(136, 0),
	7: Vector2(160, 0),
	8: Vector2(184, 0),
	9: Vector2(208, 0),
}

func display_digits(num):
	var str
	var digit : int
	
	# Convert num into a 3-digits number string
	str = "%03d" % num
	
	for i in 3:
		digit = int(str[i])
		if digit != 1:
			get_child(i).texture.region = Rect2(digit_coords[digit], Vector2(24,36))
		else:
			get_child(i).texture.region = Rect2(digit_coords[digit], Vector2(16,36))

