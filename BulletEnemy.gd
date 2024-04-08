extends RigidBody

var velo:Vector3 = Vector3()

var active:bool = false

func activate():
	active = true
	$Timer.start(2.0)

func deactivate():
	active = false

func _physics_process(_delta:float) -> void:
	if active:
		set_linear_velocity(velo)

func _on_Area_body_entered(body):
	if body.is_in_group("Asteroid"):
		#queue_free()
		deactivate()

func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		get_tree().call_group("Gamestate", "player_damage")
		#queue_free()
		deactivate()


func _on_Timer_timeout():
	deactivate()
