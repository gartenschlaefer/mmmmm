# --
# mystery murder world

class_name MysteryMurderWorld extends Node2D

# signals
signal win_condition

# refs
@onready var dialogue_panel: DialoguePanel = $hud/dialogue_panel
@onready var notepage: Control = $hud/notepage


func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("toggle_notes")):
		notepage.visible = !notepage.visible


func check_win_condtion():

	# todo:
	# implement win condition

	# emit signal 
	win_condition.emit()
