extends Node

class_name ColectableItem

func add_item(item_name:String):
	Events.emit_signal("receivedItem", item_name)
