# --
# dialogue

class_name Dialogue extends Resource

# exports
@export var dialogue_state_pieces: Array[DialogueStatePieces]
@export var dialogue_picture: Texture2D
@export var character: Character_Enum.Characters

# vars
var actual_dialogue_state


func _ready():
	pass


func reset():

	# null safety
	if actual_dialogue_state >= len(dialogue_state_pieces): return
	if dialogue_state_pieces[actual_dialogue_state] == null: return

	# reset actual state
	dialogue_state_pieces[actual_dialogue_state].reset()


func get_next_dialogue_piece() -> DialoguePiece: 

	# null safety
	if actual_dialogue_state >= len(dialogue_state_pieces): return null
	if dialogue_state_pieces[actual_dialogue_state] == null: 

		# todo: not implemented or random dialogue
		var debug_dialogue_piece = DialoguePiece.new()
		debug_dialogue_piece.set_text_piece("Sorry Sir, this dialogue in not implemented!")
		var debug_dialogue_pieces = DialogueStatePieces.new()
		debug_dialogue_pieces.set_dialogue_pieces([debug_dialogue_piece])

		# create not implemented dialogue state
		dialogue_state_pieces[actual_dialogue_state] = debug_dialogue_pieces

	return dialogue_state_pieces[actual_dialogue_state].get_next_dialogue_piece()


func get_dialogue_texture(): return dialogue_picture

func set_dialogue_state(target_state: int):

	# set dialogue state
	actual_dialogue_state = target_state
