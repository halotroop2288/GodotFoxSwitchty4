extends RigidBody

var velo = Vector3()

func _physics_process(_delta):
	
	set_linear_velocity(velo)

func _on_Area_body_entered(body):
	if body.is_in_group("Asteroid"):
		print("print")
		queue_free()

func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		get_tree().call_group("Gamestate", "player_damage")
		queue_free()
