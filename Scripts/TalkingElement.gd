extends Node

class_name TalkingElement

@onready var area_3d = $Area3D
@export var text_resource : TextArrResource

var inside_collision = false
var talking = false

func _ready():
	_setup_area()
	area_3d.connect("body_entered", _body_entered)
	area_3d.connect("body_exited", _body_exited)

func _setup_area():
	area_3d.set_collision_layer_value(1, false)
	area_3d.set_collision_mask_value(1, false)
	area_3d.set_collision_mask_value(2, true)

func _body_entered(_body):
	inside_collision = true

func _body_exited(_body):
	inside_collision = false

func _input(event):
	if event.is_action_pressed("talk"):
		trigger_text()

func trigger_text():
	if inside_collision:
		var current_text = text_resource.get_next_text()
		print(current_text)
		if current_text == null:
			Events.emit_signal("stopTalking")
			talking = false
		else:
			if !talking:
				talking = true
				Events.emit_signal("startTalking")
	else:
		print('notextos')

