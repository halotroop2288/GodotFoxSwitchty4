extends RigidBody

var BombExplosion = load("res://BombExplosion.tscn")

var velo:Vector3 = Vector3()

var active:bool = false

func _physics_process(_delta:float) -> void:
	if active:
		set_linear_velocity(velo)

func activate() -> void:
	$BombExplosion/Particles.emitting = false
	$Area/CollisionShape2.disabled = true
	$MeshInstance.show()
	linear_velocity = velo
	active = true

func deactivate() -> void:
	$BombExplosion/Particles.emitting = false
	$Area/CollisionShape2.disabled = true
	$MeshInstance.hide()
	linear_velocity = Vector3(0, 0, 0)
	active = false

func explode() -> void:
	$BombExplosion/Particles.emitting = true
	$MeshInstance.visible = false
	$Area/CollisionShape2.disabled = false
	yield(get_tree().create_timer(1.5),"timeout")
	#queue_free()
	deactivate()

func _on_Area_body_entered(body) -> void:
	if body.is_in_group("Enemies"):
		get_tree().call_group("Gamestate", "enemy_killed")
		explode()
		body.explode()
	
	if body.is_in_group("Asteroid"):
		get_tree().call_group("Gamestate", "asteroid_hit")
		explode()

func _on_Timer_timeout() -> void:
	explode()
