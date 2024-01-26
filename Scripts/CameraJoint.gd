extends SpringArm3D

@export var mouse_sensitivity := 0.05
@onready var cam = $Camera3D

func _ready():
	set_as_top_level(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.x -= event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -90.0, 30.0)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0.0, 360.0)

func cam_zoom_in():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(cam, "fov", 50, 0.5).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "position", Vector3(position.x,position.y-1, position.z), 0.5).set_trans(Tween.TRANS_SINE)

func cam_zoom_out():
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(cam, "fov", 75, 0.5).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "position", Vector3(position.x,position.y+1, position.z), 0.5).set_trans(Tween.TRANS_SINE)
	await tween.step_finished
	return true
