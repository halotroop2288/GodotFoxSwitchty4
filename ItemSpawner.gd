extends Spatial

onready var main:Node = get_tree().current_scene

const Rings:PackedScene = preload("res://SilverRings.tscn")
const GoldRings:PackedScene = preload("res://GoldRings.tscn")
const SmartBombs:PackedScene = preload("res://SmartBomb.tscn")
var RingTicker:int = 0

var smart_bomb_pool:Array = []
const smart_bomb_max:int = 10

var ring_pool:Array = []
const ring_max:int = 10

var gold_ring_pool:Array = []
const gold_ring_max:int = 10

func _ready() -> void:
	loader()

func loader() -> void:
	fillSmartBombPool()
	fillGoldRingPool()
	fillRingPool()

func super_loader() -> void:
	var smart_bomb_thread:Thread = Thread.new()
	smart_bomb_thread.start(self, "fillSmartBombPool")
	var ring_thread:Thread = Thread.new()
	ring_thread.start(self, "fillRingPool")
	var gold_ring_thread:Thread = Thread.new()
	gold_ring_thread.start(self, "fillGoldRingPool")
	while true:
		if smart_bomb_thread.is_alive() == false:
			smart_bomb_thread.wait_to_finish()
		if ring_thread.is_alive() == false:
			ring_thread.wait_to_finish()
		if gold_ring_thread.is_alive() == false:
			gold_ring_thread.wait_to_finish()
		if not (gold_ring_thread.is_active() and ring_thread.is_active() and smart_bomb_thread.is_active()):
			break

func fillRingPool() -> void:
	ring_pool.clear()
	var a_ring:int = 0
	while a_ring < ring_max:
		ring_pool.append(Rings.instance())
		ring_pool[a_ring].deactivate()
		a_ring += 1

func fillGoldRingPool() -> void:
	gold_ring_pool.clear()
	var a_ring:int = 0
	while a_ring < gold_ring_max:
		gold_ring_pool.append(GoldRings.instance())
		gold_ring_pool[a_ring].deactivate()
		a_ring += 1

func fillSmartBombPool() -> void:
	smart_bomb_pool.clear()
	var a_bomb:int = 0
	while a_bomb < smart_bomb_max:
		smart_bomb_pool.append(SmartBombs.instance())
		smart_bomb_pool[a_bomb].deactivate()
		a_bomb += 1

func getRingFromPool():
	for possible_rings in ring_pool:
		if not possible_rings.active:
			return possible_rings

func getGoldRingFromPool():
	for possible_rings in gold_ring_pool:
		if not possible_rings.active:
			return possible_rings

func getSmartBombFromPool():
	for possibly_dangerous in smart_bomb_pool:
		if not possibly_dangerous.active:
			return possibly_dangerous

func spawnRing() -> void:
	if ring_pool.empty():
		return
	var rings = getRingFromPool()
	if not rings.is_inside_tree():
		main.add_child(rings)
	rings.transform.origin = transform.origin + Vector3(rand_range(-15,15), rand_range(-10,10), 0)
	rings.activate()

func spawnGoldRing() -> void:
	if gold_ring_pool.empty():
		return
	var goldrings = getGoldRingFromPool()
	if not goldrings.is_inside_tree():
		main.add_child(goldrings)
	goldrings.transform.origin = transform.origin + Vector3(rand_range(-10,10), rand_range(-5,5), 0)
	goldrings.activate()

func spawnSmartBomb() -> void:
	if smart_bomb_pool.empty():
		return
	var smartbomb = getSmartBombFromPool()
	if not smartbomb.is_inside_tree():
		main.add_child(smartbomb)
	smartbomb.transform.origin = transform.origin + Vector3(rand_range(-10,10), rand_range(-5,5), 0)
	smartbomb.activate()

func _on_Timer_timeout() -> void:
	RingTicker += 1
	if RingTicker > 3:
		spawnGoldRing()
		RingTicker = 0
	else:
		spawnRing()

func _on_Timer2_timeout() -> void:
	spawnSmartBomb()
