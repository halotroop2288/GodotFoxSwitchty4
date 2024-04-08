extends KinematicBody
class_name SilverRing

var spd:float = 50
var variation:float = rand_range(-0.25, 0.5)
var coinrotate:int = 3
var active:bool = false

func activate():
	$AnimationPlayer.stop(true)
	#rotation_degrees = Vector3(0, 0, 0)
	#scale = Vector3(2, 2, 2)
	self.show()
	active = true

func deactivate():
	self.hide()
	active = false

func _physics_process(_delta:float) -> void:
	if active:
		move_and_slide(Vector3(variation, variation, spd))
		rotation_degrees.y += coinrotate
		if transform.origin.z > 10:
			#queue_free()
			deactivate()

func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		$AnimationPlayer.play("caught")
		#get_node("AnimationPlayer").play("caught")
