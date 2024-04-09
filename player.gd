extends KinematicBody

const MAXSPEED:int = 45
const ACCELERATION:int = 1
var inputVector:Vector3 = Vector3()
var velo:Vector3 = Vector3()

onready var guns:Array  = [$Gun2,$Gun3]
onready var main:Node = get_tree().current_scene

const Bullet:PackedScene = preload("res://Bullet.tscn")
var bullet_pool:Array = []
const bullet_max:int = 50

const Bomb:PackedScene = preload("res://Bomb.tscn")
var bomb_pool:Array = []
const bomb_max:int = 20

#var cooldown = 0
#const COOLDOWN = 8

func _ready() -> void:
	fillBombPool()
	fillBulletPool()

func _physics_process(_delta:float) -> void:
	exit()
	Shooting()
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	inputVector = inputVector.normalized()
	velo.x = move_toward(velo.x, inputVector.x * MAXSPEED, ACCELERATION)
	velo.y = move_toward(velo.y, inputVector.y * MAXSPEED, ACCELERATION)
	rotation_degrees.z = velo.x * -2
	rotation_degrees.x = velo.y / 2
	rotation_degrees.y = -velo.x / 2
	move_and_slide(velo)
	transform.origin.x = clamp(transform.origin.x, -14, 14)
	transform.origin.y = clamp(transform.origin.y, -9, 9)
	
	#Banking
	if Input.is_action_pressed("ui_page_up"):
		rotation_degrees.z += 100
		
	if Input.is_action_pressed("ui_page_down"):
		rotation_degrees.z += -100
	
	if Input.is_action_just_pressed("ui_home"):
		get_tree().call_group("Gamestate", "spinright")
		$Spin.play()
	if Input.is_action_just_pressed("ui_end"):
		get_tree().call_group("Gamestate", "spinright")
		$Spin.play()
	if Input.is_action_just_pressed("ui_cancel"):
		if Global.bombs >= 1:
			$Bomb.play()
			var bomb = getBombFromPool()
			if not bomb.is_inside_tree():
				main.add_child(bomb)
			bomb.transform = global_transform
			bomb.velo = bomb.transform.basis.z * -50
			bomb.activate()
			get_tree().call_group("Gamestate", "bombs_down")

func fillBulletPool() -> void:
	bullet_pool.clear()
	var a_bullet:int = 0
	while a_bullet < bullet_max:
		bullet_pool.append(Bullet.instance())
		bullet_pool[a_bullet].deactivate()
		a_bullet += 1

func fillBombPool() -> void:
	bomb_pool.clear()
	var a_bomb:int = 0
	while a_bomb < bomb_max:
		bomb_pool.append(Bomb.instance())
		bomb_pool[a_bomb].deactivate()
		a_bomb += 1

func getBulletFromPool():
	for projectiles in bullet_pool:
		if not projectiles.active:
			return projectiles

func getBombFromPool():
	for bombs in bomb_pool:
		if not bombs.active:
			return bombs

func Shooting() -> void:
	if Input.is_action_just_pressed("ui_accept"): 
		$Shoot.play()
		for i in guns:
			var bullet = getBulletFromPool()
			if not bullet.is_inside_tree():
				main.add_child(bullet)
			bullet.transform = i.global_transform
			bullet.velo = bullet.transform.basis.z * -400
			bullet.activate()

func _on_Area_body_entered(body) -> void:
		if body.is_in_group("Enemies"):
			get_tree().call_group("Gamestate", "player_damage")
		if body.is_in_group("Asteroid"):
			get_tree().call_group("Gamestate", "player_damage")
		if body.is_in_group("SilverRing"):
			get_tree().call_group("Gamestate", "rings_up")
		if body.is_in_group("GoldRing"):
			get_tree().call_group("Gamestate", "goldrings_up")
		if body.is_in_group("SmartBomb"):
			get_tree().call_group("Gamestate", "bombs_up")

func explode() -> void:
	$Explosion/Particles.emitting = true
	$Area/CollisionShape.disabled = true
	yield(get_tree().create_timer(0.5),"timeout")
	queue_free()

func exit() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
