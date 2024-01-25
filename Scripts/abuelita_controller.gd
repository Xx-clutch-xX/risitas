extends CharacterBody3D

@export var speed:= 2.0
@export var rotation_speed:= 10.0
@export var jump_strength:= 4.0
@export var gravity:= 30.0
@export var _model: Node3D
@export var _spring_arm: SpringArm3D

#var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

func _physics_process(delta):
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_direction.z = Input.get_action_strength("back") - Input.get_action_strength("forward")
	move_direction = move_direction.rotated(Vector3.UP, _spring_arm.rotation.y).normalized()
	
	velocity.x = move_direction.x * speed
	velocity.z = move_direction.z * speed
	velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("jump")
	
	if is_jumping:
		velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	
	move_and_slide()
	
	var look_direction = Vector2(velocity.z, velocity.x)

	if velocity.length() > 1 and look_direction != Vector2.ZERO:
		_model.rotation.y = lerp_angle(_model.rotation.y, look_direction.angle(), delta * rotation_speed)


func _process(_delta):
	_spring_arm.position = Vector3(position.x, position.y + 1, position.z)
