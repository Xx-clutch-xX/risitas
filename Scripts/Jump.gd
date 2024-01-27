# Jump.gd
extends State

func enter(msg := {}) -> void:
	owner._anim_tree.set("parameters/StateMachine/conditions/jump", true)
	owner.velocity.y = owner.jump_strength
	owner.velocity.x = owner.velocity.x * owner.jump_distance
	owner.velocity.z = owner.velocity.z * owner.jump_distance
	owner._snap_vector = Vector3.ZERO

func physics_update(delta):
	owner.velocity.y -= owner.gravity * delta
	var just_landed = owner.is_on_floor() and owner._snap_vector == Vector3.ZERO
	
	owner.move_and_slide()
	
	if just_landed:
		owner._snap_vector = Vector3.DOWN
		owner.velocity = Vector3.ZERO
		owner._anim_tree.set("parameters/StateMachine/conditions/jump", false)
		await owner._anim_tree.animation_finished
		if !owner.talking:
			state_machine.transition_to("Idle")

func update(_delta):
	owner._spring_arm.position = Vector3(owner.position.x, owner.position.y + 1, owner.position.z)
