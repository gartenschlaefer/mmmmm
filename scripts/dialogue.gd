# --
# dialogue

class_name Dialogue extends Resource

# exports
@export var dialogue_state_pieces: Array[DialogueStatePieces]
@export var dialogue_picture: Texture2D

# vars
var actual_dialogue_state


func _ready():
	pass


func reset():

	# reset dialogue
	pass


func get_next_dialogue_piece() -> DialoguePiece: return dialogue_state_pieces[actual_dialogue_state].get_next_dialogue_piece()
func get_dialogue_texture(): return dialogue_picture

func set_dialogue_state(target_state: int):

	# set dialogue state
	actual_dialogue_state = target_state
