extends Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		self.rotate_x(-event.relative.y * 0.005)
		self.rotation.x = clamp(self.rotation.x, deg_to_rad(-30), deg_to_rad(90))
