extends RigidBody2D

@export var time_to_despawn: float = 2
var timer: float = 0.0

func _ready():
	timer = time_to_despawn
	
func _process(delta):
	timer -= delta
	
	if timer <=0:
		queue_free()
