extends Node

var numero_camarones = 0

func _ready():
	TranslationServer.set_locale("es")
	Events.connect("objetoRecibido", recibe)

func recibe(_item):
	if _item == 'camaron':
		numero_camarones = numero_camarones + 1
		if numero_camarones == 3:
			Events.emit_signal("camaronesCompletados")
			print('ganascamaronesa')

