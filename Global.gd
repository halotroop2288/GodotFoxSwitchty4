extends Node

var rings:int = 0
var bombs:int = 2

var Rings = preload("res://SilverRings.tscn")
var GoldRings = preload("res://GoldRings.tscn")
var SmartBombs = preload("res://SmartBomb.tscn")

#Maxes in here were arbitrarily "that sounds about right" chosen

var bullet_pool:Array = []
var bullet_iter:int = 0
const bullet_max:int = 30

func fill_pool_internal(res, pool:Array, maximum:int):
	while pool.size() < maximum:
		pool.append(res.instance())

func pool_fetch_internal(pool:Array, iterator:int, maximum:int):
	var ret = pool[iterator]
	iterator += 1
	if iterator > maximum:
		iterator = 0
	return ret

func fill_bullet_pool():
	pass

func get_bullet_from_pool():
	return pool_fetch_internal(bullet_pool, bullet_iter, bullet_max)
