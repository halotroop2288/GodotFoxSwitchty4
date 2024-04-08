extends KinematicBody

const BulletEnemy = preload("res://BulletEnemy.tscn")
var bullet_enemy_pool:Array
const bullet_enemy_max:int = 10

var spd = rand_range(40,100)
var variation = rand_range(-1,1)
const explosion = 0.6
var explode_countdown = explosion
var velo:Vector3 = Vector3()
onready var gun  = $Gun
var active:bool = false

func _ready():
	fillBulletEnemyPool()

func activate():
	$Explosion/Particles.emitting = false
	$EnemyMesh.visible = true
	$CollisionShape.disabled = false
	active = true

func deactivate():
	$Explosion/Particles.emitting = false
	$EnemyMesh.visible = false
	$CollisionShape.disabled = true
	active = false

func fillBulletEnemyPool():
	bullet_enemy_pool.clear()
	var enemy_bullet:int = 0
	while enemy_bullet < bullet_enemy_max:
		bullet_enemy_pool.append(BulletEnemy.instance())
		bullet_enemy_pool[enemy_bullet].deactivate()
		enemy_bullet += 1

func getBulletEnemyFromPool():
	for bullets in bullet_enemy_pool:
		if not bullets.active:
			return bullets

func _physics_process(_delta:float) -> void:
	if active:
		move_and_slide(Vector3(variation,variation,spd))
		if transform.origin.z > 1:
			#queue_free()
			deactivate()

func explode() -> void:
	$Explosion/Particles.emitting = true
	$EnemyMesh.visible = false
	$CollisionShape.disabled = true
	yield(get_tree().create_timer(0.5),"timeout")
	#queue_free()
	deactivate()

func _on_Timer_timeout():
	var bullet = getBulletEnemyFromPool()
	if not bullet.is_inside_tree():
		get_parent().add_child(bullet)
	bullet.transform = global_transform
	bullet.velo = bullet.transform.basis.z * 225
	bullet.activate()

func _on_Area_area_entered(area):
	if area.is_in_group("Player"):
		explode()
