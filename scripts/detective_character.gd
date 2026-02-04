# --
# detective character

class_name DetectiveCharacter extends CharacterBody2D

# signals
signal detective_has_new_dialogue(dialogue: Dialogue, hint_state: int)
signal detective_requests_next_dialogue_piece
signal detective_leaves_conservation
signal detective_talks_to_npc(character: Character_Enum.Characters)
signal detective_has_collected_hint(hint: Character_Enum.Hints)
signal detective_changed_hint_state(hint_state: int)

# refs
@onready var detective_sprite : AnimatedSprite2D  = $AnimatedSprite2D
@onready var detective_mask : Sprite2D = $Sprite2D
@onready var idle_timer : Timer = $IdleTimer
@onready var interaction_area: Area2D = $interaction_area

# var
var old_direction  : Vector2
var active_dialogue: Dialogue = null
var active_hint: Hint = null
var actual_hint_state: int = 0
var active_guest : Character_Enum.Characters = Character_Enum.Characters.NONE;
var collected_hints: Array[int]

# const
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready():

	# signal connection
	interaction_area.area_entered.connect(self.on_area_entered)
	interaction_area.area_exited.connect(self.on_area_exited)


func _physics_process(_delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction := Input.get_axis("left", "right")
	var vertical_direction := Input.get_axis("up", "down")
	var direction = Vector2(horizontal_direction, vertical_direction)
	if direction != old_direction:
		if direction:
			velocity = direction * SPEED
			
			idle_timer.stop()
			detective_sprite.animation = "walk"
			detective_sprite.frame = 1
			detective_sprite.play()
			
			var flip = direction.x > 0
			detective_sprite.flip_h = flip
			detective_mask.flip_h = flip
				
		else:
			velocity = Vector2(0, 0)
			
			idle_timer.start()
			detective_sprite.frame = 0
			detective_sprite.stop()
	old_direction = direction
	move_and_slide()


func _input(_event):

	# only interact input
	if not Input.is_action_just_pressed("interact"): return

	# dialogue
	if not active_dialogue == null:

		# update dialogue
		detective_requests_next_dialogue_piece.emit()
		if(active_guest != Character_Enum.Characters.NONE):
			detective_talks_to_npc.emit(active_guest);

	# there is an active hint
	if active_hint != null:

		# add to collected hints
		collected_hints.append(active_hint.get_hint_type())
		detective_has_collected_hint.emit(active_hint.get_hint_type())
		active_hint.disable()
		active_hint = null


func _on_idle_timer_timeout() -> void:
	detective_sprite.animation = "idle"
	detective_sprite.play()


func start_dialogue_effects():

	# state effect invitation
	if actual_hint_state == 0:

		# check has invitation
		if not self.has_invitation(): return

		# mole -> invitation
		if active_guest != Character_Enum.Characters.MOLE: return

		# increase hint state
		self.increase_the_hint_state()
		return

	# state effect invitation
	if actual_hint_state == 1:

		# mole -> invitation
		if active_guest != Character_Enum.Characters.BUNNY: return

		# check has carrot
		if not self.has_carrot(): return

		# increase hint state
		self.increase_the_hint_state()
		return


	# state effect invitation
	if actual_hint_state == 2:

		# mole -> invitation
		if active_guest != Character_Enum.Characters.OWL: return

		# check has book
		if not self.has_book(): return

		# increase hint state
		self.increase_the_hint_state()
		return

	# state effect invitation
	if actual_hint_state == 3:

		# mole -> invitation
		if active_guest != Character_Enum.Characters.FOX: return

		# check has toolbox
		if not self.has_toolbox(): return

		# increase hint state
		self.increase_the_hint_state()
		return


func has_invitation():

	# hint check
	for hint_id in collected_hints:
		if hint_id == Character_Enum.Hints.Invitation: return true
	return false


func has_carrot():

	# hint check
	for hint_id in collected_hints:
		if hint_id == Character_Enum.Hints.Carrot: return true
	return false


func has_book():

	# hint check
	for hint_id in collected_hints:
		if hint_id == Character_Enum.Hints.Book: return true
	return false


func has_toolbox():

	# hint check
	for hint_id in collected_hints:
		if hint_id == Character_Enum.Hints.Toolbox: return true
	return false


func on_area_entered(area: Area2D):

	# get parent
	var interaction_object = area.get_parent()

	# guest interaction
	if interaction_object is GuestCharacter:

		# get dialogue
		active_dialogue = interaction_object.get_dialogue()
		active_guest = interaction_object.get_character();

		# new dialogue
		detective_has_new_dialogue.emit(active_dialogue, actual_hint_state)

		# end
		return

	# hint interaction
	if interaction_object is Hint:

		# is active hint
		if not interaction_object.get_is_hint_active(): return

		# active hint
		active_hint = interaction_object

		# end
		return


func increase_the_hint_state():

	# hint state increase
	actual_hint_state += 1

	# emit signal
	detective_changed_hint_state.emit(actual_hint_state)


func on_area_exited(area: Area2D):

	# get parent
	var interaction_object = area.get_parent()

	# guest character
	if interaction_object is GuestCharacter: 

		# reset dialogue
		active_dialogue = null
		active_guest = Character_Enum.Characters.NONE

		# leave conservation
		detective_leaves_conservation.emit()

		return

	# hint
	if interaction_object is Hint: 

		# active hint disable
		active_hint = null

		return
		

func get_hint_state(): return actual_hint_state
