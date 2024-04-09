extends Spatial

var wings:int = 1
var goldrings:int = 0
var health:int = 3

func _ready() -> void:
	Global.rings = 0
	Global.bombs = 1
	get_node("AnimationPlayer").play("start")
	add_to_group("Gamestate")
	update_GUI()

func update_GUI() -> void:
	get_tree().call_group("GUI", "update_gui_wings", wings)
	get_tree().call_group("GUI", "update_gui_bombs", Global.bombs)
	get_tree().call_group("GUI", "update_gui_rings", Global.rings)
	get_tree().call_group("GUI", "update_gui_goldrings", goldrings)
	get_tree().call_group("GUI", "update_gui_health", health)

func wings_up() -> void:
	wings += 1
	update_GUI()

func wings_down() -> void:
	wings -= 1
	if wings < 0:
		get_tree().call_group("Player", "explode")
		yield(get_tree().create_timer(0.5),"timeout")
		end_game()
	else:
		$GoldRings3.play()
		health = 3
		update_GUI()
	update_GUI()

func bombs_up() -> void:
	Global.bombs += 1
	$BombPickup.play()
	update_GUI()

func bombs_down() -> void:
	Global.bombs -= 1
	update_GUI()

func rings_up() -> void:
	Global.rings += 10
	$SilverRing.play()
	update_GUI()

func enemy_killed() -> void:
	Global.rings += 1
	$EnemyKilled.play()
	update_GUI()

func rings_down() -> void:
	Global.rings -= 1
	update_GUI()

func goldrings_up() -> void:
	goldrings += 1
	health += 1
	$SilverRing.play()
	if goldrings == 3:
		$GoldRings3.play()
		goldrings = 0
		wings_up()
		update_GUI()
	update_GUI()

func asteroid_hit() -> void:
	$Asteroid_Hit.play()

func player_damage() -> void:
	health -= 1
	$Player_Hit.play()
	get_node("AnimationPlayer").play("shake")
	if health == 1:
		$DamageAlert.play()
		update_GUI()
	if health == 0:
		wings_down()
		update_GUI()
	update_GUI()

func end_game() -> void:
	get_tree().change_scene("res://GameOver.tscn")

func spinright() -> void:
	get_node("AnimationPlayer").play("spinright")
