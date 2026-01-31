# --
# mystery murder world

class_name MysteryMurderWorld extends Node2D
@onready var notepage: Control = $hud/notepage

signal win_condition

func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("toggle_notes")):
		notepage.visible = !notepage.visible

func check_win_condtion():

	# todo:
	# implement win condition

	# emit signal 
	win_condition.emit()
