extends TextureRect

@export var hover_amount := 15.0
@export var hover_time := 0.5

func _ready():
	hover_up()

func hover_up():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y + hover_amount), hover_time).set_trans(Tween.TRANS_SINE)
	await tween.step_finished
	hover_down()

func hover_down():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", Vector2(position.x, position.y - hover_amount), hover_time)
	await tween.step_finished
	hover_up()
