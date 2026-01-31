extends Node

# refs
@export var actual_dialogue: Dialogue
@onready var mystery_murder_world: MysteryMurderWorld = $mystery_murder_world

# vars
var actual_state: int = 0
var dialogue_panel:DialoguePanel = null


func _ready():

	# actual state init
	actual_state = 0
	
	#print("dialogue: ")
	#print_rich("img: [img=100]art/icon.svg[/img]")

	# connect
	dialogue_panel = mystery_murder_world.dialogue_panel

	# load dialogue
	dialogue_panel.load_dialogue(actual_dialogue, actual_state)


func _input(_event):

	# update dialogue
	if Input.is_action_just_pressed("interact"): dialogue_panel.next_dialogue_piece()
	

func next_state():

	# next state
	actual_state += 1
