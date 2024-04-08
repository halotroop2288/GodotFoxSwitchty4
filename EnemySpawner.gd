extends Spatial

onready var main = get_tree().current_scene
var Enemy = preload("res://enemy.tscn")
var Asteroid = preload("res://Asteroid.tscn")
var Asteroid2 = preload("res://Asteroid2.tscn")
var Asteroid3 = preload("res://Asteroid3.tscn")

var enemy_pool:Array = []
const enemy_max:int = 25

var asteroid_1_pool:Array = []
const asteroid_1_max:int = 25

var asteroid_2_pool:Array = []
const asteroid_2_max:int = 25

var asteroid_3_pool:Array = []
const asteroid_3_max:int = 25

func _ready():
	fillEnemyPool()
	fillAsteroid1Pool()
	fillAsteroid2Pool()
	fillAsteroid3Pool()

func fillEnemyPool():
	enemy_pool.clear()
	var an_enemy:int = 0
	while an_enemy < enemy_max:
		enemy_pool.append(Enemy.instance())
		enemy_pool[an_enemy].deactivate()
		an_enemy += 1

func fillAsteroid1Pool():
	asteroid_1_pool.clear()
	var a_rock:int = 0
	while a_rock < asteroid_1_max:
		asteroid_1_pool.append(Asteroid.instance())
		asteroid_1_pool[a_rock].deactivate()
		a_rock += 1

func fillAsteroid2Pool():
	asteroid_2_pool.clear()
	var a_rock:int = 0
	while a_rock < asteroid_2_max:
		asteroid_2_pool.append(Asteroid2.instance())
		asteroid_2_pool[a_rock].deactivate()
		a_rock += 1

func fillAsteroid3Pool():
	asteroid_3_pool.clear()
	var a_rock:int = 0
	while a_rock < asteroid_3_max:
		asteroid_3_pool.append(Asteroid3.instance())
		asteroid_3_pool[a_rock].deactivate()
		a_rock += 1

func getEnemyFromPool():
	for enemies in enemy_pool:
		if not enemies.active:
			return enemies

func getAsteroid1FromPool():
	for big_rocks in asteroid_1_pool:
		if not big_rocks.active:
			return big_rocks

func getAsteroid2FromPool():
	for big_rocks in asteroid_2_pool:
		if not big_rocks.active:
			return big_rocks

func getAsteroid3FromPool():
	for big_rocks in asteroid_3_pool:
		if not big_rocks.active:
			return big_rocks

func spawnEnemy():
	var enemy = getEnemyFromPool()
	if not enemy.is_inside_tree():
		main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	enemy.activate()

func spawnAsteroid1():
	var asteroid = getAsteroid1FromPool()
	if not asteroid.is_inside_tree():
		main.add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	asteroid.activate()

func spawnAsteroid2():
	var asteroid = getAsteroid2FromPool()
	if not asteroid.is_inside_tree():
		main.add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-20,20), rand_range(-15,15), 0)
	asteroid.activate()

func spawnAsteroid3():
	var asteroid = getAsteroid3FromPool()
	if not asteroid.is_inside_tree():
		add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	asteroid.activate()

func _on_Timer_timeout():
	spawnEnemy()

func _on_Timer2_timeout():
	spawnAsteroid1()

func _on_Timer3_timeout():
	spawnAsteroid2()

func _on_Timer4_timeout():
	spawnAsteroid3()
