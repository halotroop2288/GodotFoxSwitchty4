extends KinematicBody

var spd = 50
var variation = rand_range(-0.25,0.5)
var bombrotate = 3

func _physics_process(_delta):
	move_and_slide(Vector3(variation,variation,spd))
	rotation_degrees.y += bombrotate
	if transform.origin.z > 10:
		queue_free()


func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		get_node("AnimationPlayer").play("caught")
