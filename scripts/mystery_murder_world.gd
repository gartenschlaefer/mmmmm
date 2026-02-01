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
@onready var hint_invitation = $hint_invitation
@onready var hint_carrot = $hint_carrot
@onready var hint_book = $hint_book
@onready var hint_toolbox = $hint_toolbox


func _ready():

	# connect
	dialogue_panel = hud.get_dialogue_panel()

	# make connections
	detective_character.detective_has_new_dialogue.connect(dialogue_panel.load_dialogue)
	detective_character.detective_requests_next_dialogue_piece.connect(dialogue_panel.next_dialogue_piece)
	detective_character.detective_leaves_conservation.connect(dialogue_panel.leave_dialogue)
	detective_character.detective_talks_to_npc.connect(notepage.characterFound)
	detective_character.detective_has_collected_hint.connect(notepage.hintFound)
	detective_character.detective_changed_hint_state.connect(self.world_hint_update)

	dialogue_panel.end_of_dialogue_reached.connect(detective_character.end_dialogue_effects)

	# disable all hints except invitation
	hint_invitation.enable()
	hint_carrot.disable()
	hint_book.disable()
	hint_toolbox.disable()


func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("toggle_notes")):
		notepage.visible = !notepage.visible


func world_hint_update(hint: Character_Enum.Hints):
		
	# invitation check -> next carrot
	if hint == 1: hint_carrot.enable()
	elif hint == 2: hint_book.enable()
	elif hint == 3: hint_toolbox.enable()

	print("character changed hint state: ", hint)

# func _input(_event):

# 	# escape
# 	if Input.is_action_just_pressed("escape"): get_tree().quit()


func check_win_condtion():

	# todo:
	# implement win condition

	# emit signal 
	win_condition.emit()
