extends KinematicBody

var spd = rand_range(20,40)
var variation = rand_range(-3,3)
var asteroidrotation = rand_range(-1,1)


func _physics_process(_delta):
	rotation_degrees.z += asteroidrotation
	rotation_degrees.y += asteroidrotation 
	rotation_degrees.x += asteroidrotation 
	
	move_and_slide(Vector3(variation,variation,spd))
	if transform.origin.z > 0:
		queue_free()
