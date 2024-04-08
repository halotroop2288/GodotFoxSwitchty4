extends Node2D

var main_scene:PackedScene = null
var loading_thread:Thread = Thread.new()

func _ready():
	loading_thread.start(self, "load_scene", null, Thread.PRIORITY_HIGH)

func _physics_process(_delta):
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func load_scene():
	main_scene = load("res://Main.tscn")

func _on_Button_pressed():
	if loading_thread.is_alive():
		return
	elif loading_thread.is_active():
		loading_thread.wait_to_finish()
	$SelectSoundPlayer.playing = true
	yield($SelectSoundPlayer, "finished")
	if main_scene != null:
		get_tree().change_scene_to(main_scene)
