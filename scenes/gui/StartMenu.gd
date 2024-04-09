extends Node2D

func _physics_process(_delta:float) -> void:
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func _on_Button_pressed() -> void:
	$SelectSoundPlayer.playing = true
	if Global.main_scene != null:
		yield($SelectSoundPlayer, "finished")
		get_tree().change_scene_to(Global.main_scene)
