extends CanvasLayer


func _input(event):
	if event.is_action_pressed("ui_select"):
		$Pause.play()
		get_tree().paused = not get_tree().paused
		$ColorRect.visible = not $ColorRect.visible
