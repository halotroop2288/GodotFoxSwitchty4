extends Node2D

onready var select_sound : AudioStreamPlayer = $SelectSound

func _physics_process(_delta:float) -> void:
	if Input.is_action_just_released("ui_select"):
		_on_Button_pressed()

func _on_Button_pressed() -> void:
	select_sound.play()
	if Global.main_scene != null:
		yield(select_sound, "finished")
		get_tree().change_scene_to(Global.main_scene)
