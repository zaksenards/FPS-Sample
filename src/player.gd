extends CharacterBody3D

@onready var shootSpot:Marker3D = $"gun/shootSpot"
@onready var ray:RayCast3D = $"RayCast3D"
@onready var camera = $"Camera3D"
@export var sensitivity = 1000

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	walk(delta)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = preload("res://prefabs/bullet.tscn").instantiate()
		bullet.global_transform = shootSpot.global_transform
		bullet.globalTransform = transform
		get_parent().add_child(bullet)

func walk(delta):
	var direction:Vector3
	direction.x = int(Input.is_action_pressed("walk_rightward")) - int(Input.is_action_pressed("walk_leftward"))
	direction.z = int(Input.is_action_pressed("walk_backward")) - int(Input.is_action_pressed("walk_forward"))
	direction.y = -1*int(!ray.is_colliding())
	direction*= 5 * delta
	direction*=(transform.basis.inverse())
	move_and_collide(direction)

func _input(event):
	if(event is InputEventMouseMotion):
		rotate_y(-event.relative.x/sensitivity)
#		Clamps  rotation in (-0.7, 0.7)
#		rotation.y = clamp(rotation.y, -0.7, 0.7)
