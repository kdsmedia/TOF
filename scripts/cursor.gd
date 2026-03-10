extends Sprite

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				self.frame = 1
			else:
				self.frame = 0
	if event is InputEventMouseMotion:
			self.position = event.position
