extends CharacterBody2D

# refs
@onready var detective_sprite : AnimatedSprite2D  = $AnimatedSprite2D
@onready var detective_mask : Sprite2D = $Sprite2D
@onready var idle_timer : Timer = $IdleTimer
@onready var interaction_area: Area2D = $interaction_area

# var
var old_direction  : Vector2

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


func _on_idle_timer_timeout() -> void:
	detective_sprite.animation = "idle"
	detective_sprite.play()


func on_area_entered(area: Area2D):

	# get parent
	var guest = area.get_parent()

	# guest character
	if not guest is GuestCharacter: return

	# get active dialogue
	print("is guest")

	# get dialogue
	print(guest.get_dialogue())


func on_area_exited(_area: Area2D):

	print("exited")
	pass
