# --
# detective character

class_name DetectiveCharacter extends CharacterBody2D

# signals
signal detective_has_new_dialogue(dialogue: Dialogue, hint_state: int)
signal detective_requests_next_dialogue_piece
signal detective_leaves_conservation
signal detective_talks_to_npc(character: Character_Enum.Characters)

# refs
@onready var detective_sprite : AnimatedSprite2D  = $AnimatedSprite2D
@onready var detective_mask : Sprite2D = $Sprite2D
@onready var idle_timer : Timer = $IdleTimer
@onready var interaction_area: Area2D = $interaction_area

# var
var old_direction  : Vector2
var active_dialogue: Dialogue = null
var actual_hint_state: int = 0
var active_guest : Character_Enum.Characters = Character_Enum.Characters.NONE;

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

	# skip
	if active_dialogue == null: return

	# update dialogue
	if Input.is_action_just_pressed("interact"): 
		detective_requests_next_dialogue_piece.emit()
		if(active_guest != Character_Enum.Characters.NONE):
			detective_talks_to_npc.emit(active_guest);


func _on_idle_timer_timeout() -> void:
	detective_sprite.animation = "idle"
	detective_sprite.play()


func on_area_entered(area: Area2D):

	# get parent
	var guest = area.get_parent()

	# guest character
	if not guest is GuestCharacter: return

	# get dialogue
	active_dialogue = guest.get_dialogue()

	active_guest = guest.get_character();

	# new dialogue
	detective_has_new_dialogue.emit(active_dialogue, actual_hint_state)


func increase_the_hint_state():
	actual_hint_state += 1


func on_area_exited(_area: Area2D):

	# reset dialogue
	active_dialogue = null
	
	active_guest = Character_Enum.Characters.NONE

	# leave conservation
	detective_leaves_conservation.emit()


func get_hint_state(): return actual_hint_state
