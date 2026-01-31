# --
# credits canvas

extends CanvasLayer

# signals
signal end_credits


func _process(_delta:float) -> void:
	
	# active check
	if not self.visible: return

	# escape and end game
	if Input.is_action_just_pressed("escape") or Input.is_action_just_pressed("interact"): end_credits.emit()


func _on_exit_button_up() -> void:
	end_credits.emit()
