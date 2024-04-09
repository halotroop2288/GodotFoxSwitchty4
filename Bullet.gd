extends RigidBody

var velo:Vector3 = Vector3()

onready var lifespan:Timer = $Timer
var active:bool = false

func activate() -> void:
	active = true
	$Area/CollisionShape.disabled = false
	lifespan.start(1.5)
	show()

func deactivate() -> void:
	active = false
	$Area/CollisionShape.disabled = true
	hide()

func _physics_process(_delta:float) -> void:
	if active:
		set_linear_velocity(velo)
		if global_translation.z < -300:
			deactivate()

func _on_Area_body_entered(body) -> void:
	if body.is_in_group("Enemies"):
		get_tree().call_group("Gamestate", "enemy_killed")
		body.explode()
		deactivate()
	if body.is_in_group("Asteroid"):
		get_tree().call_group("Gamestate", "asteroid_hit")
		deactivate()


func _on_Timer_timeout() -> void:
	deactivate()
