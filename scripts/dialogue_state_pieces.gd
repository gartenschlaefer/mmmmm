# --
# dialogue state pieces

class_name DialogueStatePieces extends Resource

# exports
@export var dialogue_pieces: Array[DialoguePiece]

# vars
var actual_piece: int = -1


# func _init(target_dialogue_piceses: Array[DialoguePiece]):

# 	# settings
# 	dialogue_pieces = target_dialogue_piceses


func get_next_dialogue_piece():
	
	# finished dialogue
	if actual_piece >= len(dialogue_pieces) - 1: 
		actual_piece = -1
		return null

	# next piece
	actual_piece += 1

	# return actual piece
	return dialogue_pieces[actual_piece]


func set_dialogue_pieces(target_pieces: Array[DialoguePiece]): dialogue_pieces = target_pieces
