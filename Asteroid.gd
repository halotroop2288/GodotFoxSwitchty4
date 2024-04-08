extends KinematicBody

var spd:int = rand_range(20, 40)
var variation:int = rand_range(-3, 3)
var asteroidrotation:float = rand_range(-1, 1)

var active:bool = false

func activate():
	active = true
	$CollisionShape.disabled = false
	show()

func deactivate():
	active = false
	$CollisionShape.disabled = true
	hide()

func _physics_process(_delta:float) -> void:
	if active:
		rotation_degrees.z += asteroidrotation
		rotation_degrees.y += asteroidrotation 
		rotation_degrees.x += asteroidrotation 
		
		move_and_slide(Vector3(variation, variation, spd))
		if transform.origin.z > 0:
			#queue_free()
			deactivate()
