# --
# dialogue panel

class_name DialoguePanel extends Panel

# exports
@export var actual_text: RichTextLabel
@export var actual_dialogue_picture_rect: TextureRect
@onready var boss_battle: Node2D = $BossBattle

# vars
var actual_dialogue = 0


func load_dialogue(target_dialogue: Dialogue, dialogue_state: int):
		
	# assertions
	assert(target_dialogue != null)

	# target dialogue
	actual_dialogue = target_dialogue

	# update texture
	actual_dialogue_picture_rect.set_texture(target_dialogue.get_dialogue_texture())

	# set state
	target_dialogue.set_dialogue_state(dialogue_state)

	# show
	#self.show()
	# first piece
	#self.next_dialogue_piece()


func next_dialogue_piece():
	
	# next piece of the dialogue
	var target_dialogue_piece: DialoguePiece = actual_dialogue.get_next_dialogue_piece()

	# make visible
	if not visible: self.show()

	# if null -> last piece reached
	if target_dialogue_piece == null:

		self.hide()
		return

	# text update
	actual_text.set_text(target_dialogue_piece.get_text_piece())


func leave_dialogue():

	# reset dialogue
	actual_dialogue.reset()
	
	# hide
	self.hide()
	boss_battle.hide()
