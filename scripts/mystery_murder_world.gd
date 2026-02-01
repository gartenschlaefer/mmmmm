# --
# mystery murder world

class_name MysteryMurderWorld extends Node2D

# signals
signal win_condition

# refs
@onready var hud: Hud = $hud
@onready var dialogue_panel: DialoguePanel = $hud/dialogue_panel
@onready var notepage: Control = $hud/notepage
@onready var detective_character: DetectiveCharacter = $detective_character


func _ready():

	# connect
	dialogue_panel = hud.get_dialogue_panel()

	# make connections
	detective_character.detective_has_new_dialogue.connect(dialogue_panel.load_dialogue)
	detective_character.detective_requests_next_dialogue_piece.connect(dialogue_panel.next_dialogue_piece)
	detective_character.detective_leaves_conservation.connect(dialogue_panel.leave_dialogue)


func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("toggle_notes")):
		notepage.visible = !notepage.visible


# func _input(_event):

# 	# escape
# 	if Input.is_action_just_pressed("escape"): get_tree().quit()


func check_win_condtion():

	# todo:
	# implement win condition

	# emit signal 
	win_condition.emit()
