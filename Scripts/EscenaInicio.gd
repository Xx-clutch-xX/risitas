extends Control
class_name EscenaHistoria

@export var textos_inicio : TextArrResource

@export var cuadros : Array[TextureRect]
@export var next_scene: PackedScene
@onready var text_label = $RichTextLabel

var current_cuadro = 0
var lock_chars = false

func _ready():
	cuadros[current_cuadro].visible = true
	call_texto()
	current_cuadro += 1
	

func _input(event):
	if event.is_action_pressed("talk") and !lock_chars:
		next_text()

func next_text():
	if current_cuadro <= textos_inicio.key_names.size() - 1:
		cuadros[current_cuadro].visible = true
		call_texto()
		current_cuadro += 1
	else:
		change_scene()

func change_scene():
	get_tree().change_scene_to_packed(next_scene)

func call_texto():
	lock_chars = true
	print(current_cuadro)
	var current_text = tr(textos_inicio.key_names[current_cuadro])
	text_label.set_visible_characters(0)
	text_label.text = current_text
	for character in current_text.length()+1:
		text_label.set_visible_characters(character)
		await get_tree().create_timer(0.03).timeout
	lock_chars = false
