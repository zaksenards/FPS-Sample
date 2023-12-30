extends StaticBody3D

@export var speed:float = 20
@onready var timer = $"Timer"
@export var globalTransform:Transform3D

func _ready():
	timer.start(1.5)

func _physics_process(delta):
	var motion = Vector3(0,0,-1)
	motion *= globalTransform.basis.inverse()
	motion *= speed * delta
	move_and_collide(motion)

func _on_timer_timeout():
	get_parent().remove_child(self)
