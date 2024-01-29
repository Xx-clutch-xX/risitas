extends ColectableItem

@onready var area_3d = $Area3D
@onready var camaron_objeto = $camaron_objeto

func _ready():
	area_3d.connect("body_entered", _body_entered)

func _body_entered(_body):
	area_3d.queue_free()
	camaron_objeto.queue_free()
	add_item('camaron')

