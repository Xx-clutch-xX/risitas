# Talk.gd
extends State

func enter(msg := {}) -> void:
	owner.velocity = Vector3.ZERO
	if msg.has("_item"):
		print(msg._item)
		Events.emit_signal("objetoRecibido", msg._item)
	else:
		print('no objeto')
	owner._anim_tree.set("parameters/StateMachine/conditions/jump", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/running", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/idle", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/fractura", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/recolecta", true)
	owner._spring_arm.cam_zoom_in()
	await owner._anim_tree.animation_finished
	state_machine.transition_to("Idle", {from_talk=true})

func physics_update(delta):
	pass

func update(_delta):
	pass
	#owner._spring_arm.position = Vector3(owner.position.x, owner.position.y + 1, owner.position.z)
