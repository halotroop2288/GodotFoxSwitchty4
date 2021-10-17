extends Spatial

onready var main = get_tree().current_scene
var Enemy = load("res://enemy.tscn")
var Asteroid = load("res://Asteroid.tscn")
var Asteroid2 = load("res://Asteroid2.tscn")
var Asteroid3 = load("res://Asteroid3.tscn")

func spawnEnemy():
	var enemy = Enemy.instance()
	main.add_child(enemy)
	enemy.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)

func spawnAsteroid1():
	var asteroid = Asteroid.instance()
	main.add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	
func spawnAsteroid2():
	var asteroid = Asteroid2.instance()
	main.add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-20,20), rand_range(-15,15), 0)
	
func spawnAsteroid3():
	var asteroid = Asteroid3.instance()
	main.add_child(asteroid)
	asteroid.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)

func _on_Timer_timeout():
	spawnEnemy()

func _on_Timer2_timeout():
	spawnAsteroid1()

func _on_Timer3_timeout():
	spawnAsteroid2()

func _on_Timer4_timeout():
	spawnAsteroid3()
