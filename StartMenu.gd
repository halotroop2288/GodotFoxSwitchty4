extends Node2D


func _physics_process(_delta):
	
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func _on_Button_pressed():
	$AudioStreamPlayer2.playing = true
	yield(get_tree().create_timer(.75),"timeout")
	get_tree().change_scene("res://Main.tscn")
