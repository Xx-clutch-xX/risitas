extends Node3D

@onready var area_3d = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	area_3d.connect("body_entered", _body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _body_entered(_body):
	print('factura de cadera')
