# Talk.gd
extends State

func enter(msg := {}) -> void:
	owner.velocity = Vector3.ZERO
	owner._anim_tree.set("parameters/StateMachine/conditions/jump", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/running", false)
	owner._anim_tree.set("parameters/StateMachine/conditions/idle", true)

func physics_update(delta):
	pass
