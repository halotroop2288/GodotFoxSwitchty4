extends Node2D

var main_scene:PackedScene = null
var loading_thread:Thread = Thread.new()
var inter:ResourceInteractiveLoader

signal loading_done

func _ready():
	connect("loading_done", self, "wrap_up", [], CONNECT_ONESHOT)
	loading_thread.start(self, "load_scene")

func _physics_process(_delta):
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func load_scene():
	inter = ResourceLoader.load_interactive("res://Main.tscn", "PackedScene")
	while inter.poll() != ERR_FILE_EOF:
		print(inter.get_stage())
	#main_scene = inter.get_resource()
	call_deferred("emit_signal", "loading_done")
	return inter.get_resource()

func wrap_up():
	main_scene = loading_thread.wait_to_finish()

func _on_Button_pressed():
	#if (not loading_thread.is_alive()) and loading_thread.is_active():
	#	loading_thread.wait_to_finish()
	#	return
	if loading_thread.is_active():
		print("No")
		return
	else:
		print("Yes")
	$SelectSoundPlayer.playing = true
	if main_scene != null:
		yield($SelectSoundPlayer, "finished")
		get_tree().change_scene_to(main_scene)
