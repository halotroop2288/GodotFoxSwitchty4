extends Node

var rings:int = 0
var bombs:int = 2

var main_scene:PackedScene = null
var loading_thread:Thread = Thread.new()

signal loading_done

func _ready() -> void:
	connect("loading_done", self, "wrap_up", [], CONNECT_ONESHOT)
	loading_thread.start(self, "load_scene", null, Thread.PRIORITY_HIGH)

func load_scene() -> void:
	var inter:ResourceInteractiveLoader = ResourceLoader.load_interactive("res://Main.tscn", "PackedScene")
	var beginning:int = Time.get_ticks_msec()
	while inter.poll() != ERR_FILE_EOF:
		print("Stage: ", inter.get_stage(), "\n ticks: ", Time.get_ticks_msec())
	print("Time elapsed:", Time.get_ticks_msec() - beginning)
	set_deferred("main_scene", inter.get_resource())
	call_deferred("emit_signal", "loading_done")
	#return inter.get_resource()

func wrap_up() -> void:
	#main_scene = loading_thread.wait_to_finish()
	loading_thread.wait_to_finish()
