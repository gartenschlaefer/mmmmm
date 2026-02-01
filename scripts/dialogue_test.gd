extends Node

# refs
@onready var hud: Hud = $mystery_murder_world/hud
@onready var detective_character: DetectiveCharacter = $mystery_murder_world/detective_character

# vars
var actual_state: int = 0
var dialogue_panel: DialoguePanel = null


func _ready():

	# actual state init
	actual_state = 0
	
	# connect
	dialogue_panel = hud.get_dialogue_panel()

	# make connections
	detective_character.detective_has_new_dialogue.connect(dialogue_panel.load_dialogue)
	detective_character.detective_requests_next_dialogue_piece.connect(dialogue_panel.next_dialogue_piece)


func _input(_event):

	# escape
	if Input.is_action_just_pressed("escape"): get_tree().quit()
	

func next_state():

	# next state
	actual_state += 1


func _on_button_button_up() -> void:

	# demo hint state increase
	detective_character.increase_the_hint_state()
		
	# hint state
	print("hint state: ", detective_character.get_hint_state())
