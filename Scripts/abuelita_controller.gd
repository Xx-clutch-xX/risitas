extends CharacterBody3D

@export var speed:= 2.0
@export var rotation_speed:= 10.0
@export var jump_strength:= 4.0
@export var jump_distance:= 3.0
@export var gravity:= 30.0
@export var _lerp_val:= 50.0
@export var _model: Node3D
@export var _spring_arm: SpringArm3D
@export var _anim_tree: AnimationTree
@export var pisadas: AudioStreamPlayer
@export var fractura: AudioStreamPlayer
@export var salto: AudioStreamPlayer

var _snap_vector := Vector3.DOWN
var talking = false
func _ready():
	Events.connect('startTalking', start_talk)
	Events.connect('stopTalking', stop_talk)

func start_talk():
	talking = true

func stop_talk():
	talking = false
