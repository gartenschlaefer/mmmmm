extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction := Input.get_axis("ui_left", "ui_right")
	var vertical_direction := Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(horizontal_direction, vertical_direction)
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2(0, 0)

	move_and_slide()
