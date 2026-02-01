extends Node

# refs
@export var actual_dialogue: Dialogue
@onready var hud: Hud = $hud
@onready var detective_character: DetectiveCharacter = $world/detective_character

# vars
var actual_state: int = 0
var dialogue_panel: DialoguePanel = null


func _ready():

	# actual state init
	actual_state = 0
	
	#print("dialogue: ")
	#print_rich("img: [img=100]art/icon.svg[/img]")

	# connect
	dialogue_panel = hud.get_dialogue_panel()

	# make connections
	detective_character.detective_has_new_dialogue.connect(dialogue_panel.load_dialogue)
	detective_character.detective_requests_next_dialogue_piece.connect(dialogue_panel.next_dialogue_piece)

	#dialogue_panel.next_dialogue_piece()


func _input(_event):

	# update dialogue
	#if Input.is_action_just_pressed("interact"): dialogue_panel.next_dialogue_piece()

	# escape
	if Input.is_action_just_pressed("escape"): get_tree().quit()
	

func next_state():

	# next state
	actual_state += 1
