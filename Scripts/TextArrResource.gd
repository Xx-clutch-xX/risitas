extends Resource

class_name TextArrResource

var text_count = -1
@export var key_names : Array[String]
@export var character_name : String

func get_next_text():
	text_count += 1
	if text_count < key_names.size():
		return key_names[text_count]
	else:
		text_count = -1
		return ''
