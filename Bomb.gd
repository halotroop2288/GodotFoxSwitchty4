extends RigidBody

#const BombExplosion:PackedScene = preload("res://BombExplosion.tscn")

var velo:Vector3 = Vector3()

var active:bool = false

func _physics_process(_delta:float) -> void:
	if active:
		set_linear_velocity(velo)

func activate() -> void:
	active = true
	$BombExplosion/Particles.emitting = false
	$Area/CollisionShape2.disabled = true
	$MeshInstance.show()
	#The following is a fix to keep the bombs from automatically blowing up
	$Timer.start(1.5)
	linear_velocity = velo

func deactivate() -> void:
	active = false
	$BombExplosion/Particles.emitting = false
	$Area/CollisionShape2.disabled = true
	$MeshInstance.hide()
	linear_velocity = Vector3(0, 0, 0)

func explode() -> void:
	if not active:
		deactivate()
		return
	$BombExplosion/Particles.restart()
	$BombExplosion/Particles.emitting = true
	$MeshInstance.visible = false
	$Area/CollisionShape2.disabled = false
	yield(get_tree().create_timer(1.5),"timeout")
	$BombExplosion/Particles.emitting = false
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
