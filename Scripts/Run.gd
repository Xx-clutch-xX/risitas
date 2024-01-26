# Run.gd
extends State

func enter(msg := {}) -> void:
	owner._anim_tree.set("parameters/StateMachine/conditions/running", true)
	pass

func physics_update(delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, owner._spring_arm.rotation.y).normalized()
	
	owner.velocity.x = lerp(owner.velocity.x, move_direction.x * owner.speed, delta * owner._lerp_val)
	owner.velocity.z = lerp(owner.velocity.z, move_direction.z * owner.speed, delta * owner._lerp_val)
	owner.velocity.y -= owner.gravity * delta
	
	var is_jumping = owner.is_on_floor() and Input.is_action_just_pressed("jump")
	
	if is_jumping:
		owner._anim_tree.set("parameters/StateMachine/conditions/running", false)
		state_machine.transition_to("Jump")
	
	owner.move_and_slide()
	
	if owner.velocity.length() == 0:
		owner._anim_tree.set("parameters/StateMachine/conditions/running", false)
		state_machine.transition_to("Idle")
	
	var look_direction = Vector2(owner.velocity.z, owner.velocity.x)
	
	if owner.velocity.length() > 1 and look_direction != Vector2.ZERO:
		owner._model.rotation.y = lerp_angle(owner._model.rotation.y, look_direction.angle(), delta * owner.rotation_speed)
	
	
	#owner._anim_tree.set("parameters/BlendSpace1D/blend_position", owner.velocity.length() / owner.speed)


func update(_delta):
	owner._spring_arm.position = Vector3(owner.position.x, owner.position.y + 1, owner.position.z)
