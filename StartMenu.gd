extends Node2D


func _physics_process(_delta):
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func _on_Button_pressed():
	$SelectSoundPlayer.playing = true
	yield($SelectSoundPlayer, "finished")
	get_tree().change_scene("res://Main.tscn")
