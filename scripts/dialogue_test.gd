extends Control

# refs
@onready var dialogue_panel:DialoguePanel = $dialogue_panel
@export var actual_dialogue: Dialogue

# vars
var actual_state: int = 0

func _ready():

	# actual state init
	actual_state = 0
	
	print("dialogue: ")
	print_rich("img: [img=100]art/icon.svg[/img]")

	# load dialogue
	dialogue_panel.load_dialogue(actual_dialogue, actual_state)


func _input(_event):

	# update dialogue
	if Input.is_action_just_pressed("interact"): dialogue_panel.next_dialogue_piece()
	

func next_state():

	# next state
	actual_state += 1
