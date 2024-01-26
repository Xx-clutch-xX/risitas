# Idle.gd
extends State

func enter(_msg := {}) -> void:
	owner.velocity = Vector3.ZERO
	owner._anim_tree.set("parameters/StateMachine/conditions/idle", true)


func physics_update(delta: float) -> void:
	# If you have platforms that break when standing on them, you need that check for 
	# the character to fall.
	#if not owner.is_on_floor():
		#state_machine.transition_to("Air")
		#return
	owner.velocity.y -= owner.gravity * delta
	var is_jumping = owner.is_on_floor() and Input.is_action_just_pressed("jump")
	
	if is_jumping:
		owner._anim_tree.set("parameters/StateMachine/conditions/idle", false)
		state_machine.transition_to("Jump")
		
	owner.move_and_slide()
	
	if Input.is_action_pressed("right") or Input.is_action_pressed("left") or Input.is_action_pressed("forward") or Input.is_action_pressed("back"):
		owner._anim_tree.set("parameters/StateMachine/conditions/idle", false)
		state_machine.transition_to("Run")

func update(_delta):
	owner._spring_arm.position = Vector3(owner.position.x, owner.position.y + 1, owner.position.z)
