extends Node

class_name TalkingElement

@onready var area_3d = $Area3D
@onready var text_label = $Control/ControlTextbox/RichTextLabel
@onready var animation = $Control/AnimationPlayer
@onready var nombre = $Control/ControlTextbox/Nombre

@export var text_resource : TextArrResource


var inside_collision = false
var talking = false
var lock_chars = false

func _ready():
	_setup_area()
	area_3d.connect("body_entered", _body_entered)
	area_3d.connect("body_exited", _body_exited)
	$Control/ControlTextbox.size = Vector2(1920, 1080)

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
	if inside_collision and !lock_chars:
		
		var current_text = text_resource.get_next_text()
		
		if current_text == null:
			animation.play("dissappears")
			text_label.text = ''
			Events.emit_signal("stopTalking")
			talking = false
		else:
			if !talking:
				talking = true
				nombre.text = text_resource.character_name
				animation.play("appears")
				Events.emit_signal("startTalking")
				
			text_label.set_visible_characters(0)
			text_label.text = current_text
			for character in current_text.length()+1:
				lock_chars = true
				text_label.set_visible_characters(character)
				await get_tree().create_timer(0.07).timeout
			lock_chars = false
			
	elif !lock_chars:
		print('notextos')

