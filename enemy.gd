extends KinematicBody

var spd = rand_range(40,100)
var variation = rand_range(-1,1)
const explosion = 0.6
var explode_countdown = explosion

func _physics_process(_delta):
	move_and_slide(Vector3(variation,variation,spd))
	if transform.origin.z > 1:
		queue_free()

func explode() -> void:
	$Explosion/Particles.emitting = true
	$EnemyMesh.visible = false
	$CollisionShape.disabled = true
	yield(get_tree().create_timer(0.5),"timeout")
	queue_free()
