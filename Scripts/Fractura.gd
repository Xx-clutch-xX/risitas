# Talk.gd
extends State

func enter(msg := {}) -> void:
	owner.velocity = Vector3.ZERO
	owner._anim_tree.set("parameters/StateMachine/conditions/jump", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/running", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/idle", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/fractura", true)
	owner._spring_arm.cam_zoom_in()

func physics_update(delta):
	pass

func update(_delta):
	pass
	#owner._spring_arm.position = Vector3(owner.position.x, owner.position.y + 1, owner.position.z)
