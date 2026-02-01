# --
# dialogue piece

class_name DialoguePiece extends Resource

@export var text_piece: String


# func _init(target_text_piece: String):

# 	# settings
# 	text_piece = target_text_piece


func get_text_piece() -> String: return text_piece
func set_text_piece(target_text): text_piece = target_text
