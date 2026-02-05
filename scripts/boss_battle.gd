extends Node2D

signal win_the_game

@onready var left_eye : Node2D = $LeftEye
@onready var right_eye : Node2D = $RightEye
@onready var tears_start : Node2D = $Tears/Start
@onready var tears_mid : Node2D = $Tears/Mid
@onready var tears_end : Node2D = $Tears/End
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
@onready var shake_timer : Timer = $ShakeTimer
@onready var tears_timer : Timer = $Tears/TearsTimer
var curr_round : int

var boss_shake_time := 0.0
var left_eye_shake_time := 0.0
var right_eye_shake_time := 0.0
var strength := 2.0
var speed := 30.0
var pos_boss := Vector2.ZERO
var pos_left_eye := Vector2.ZERO
var pos_right_eye := Vector2.ZERO
var left_eye_state := eye_state.NORMAL
var right_eye_state := eye_state.NORMAL
var right_eye_shake := false
var left_eye_shake := false

enum eye_state {NORMAL,BULGE,SMALL}

func _ready() -> void:
	pos_boss = position
	pos_left_eye = left_eye.position
	pos_right_eye = right_eye.position
	reset()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_page"):
		give_clue()
	elif event.is_action_pressed("prev_page"):
		reset()

func _process(delta: float) -> void:
	if not shake_timer.is_stopped():
		boss_shake_time += delta
		shake_node(self, pos_boss, boss_shake_time)
	if left_eye_shake:
		left_eye_shake_time += delta
		shake_node(left_eye,pos_left_eye,left_eye_shake_time)
	if right_eye_shake:
		right_eye_shake_time += delta
		shake_node(right_eye,pos_right_eye,right_eye_shake_time)

func shake_node(target: Node2D, base_pos: Vector2, time: float) -> void:
	target.position = base_pos + Vector2(
		sin(time * speed),
		cos(time * speed * 1.3)
	) * strength

func reset():
	left_eye.hide()
	right_eye.hide()
	tears_start.hide()
	tears_mid.hide()
	tears_end.hide()
	left_eye_shake = false
	right_eye_shake = false
	curr_round = 0

func give_clue():
	if has_clue_left():
		curr_round += 1
		shake_timer.start()
		match curr_round:
			1:
				eye_movement(false)
			2:
				eye_movement(false)
			3:
				eye_movement(true)
				tears_start.show()
			4:
				eye_movement(true)
				tears_mid.show()
				tears_timer.start()
	else:
		reset()

func eye_movement(start_shake: bool):
	match randi_range(1,3):
		1:
			left_eye_state = advance_eye_movement(left_eye,left_eye_state,start_shake)
		2:
			right_eye_state = advance_eye_movement(right_eye,right_eye_state,start_shake)
		3:
			left_eye_state = advance_eye_movement(left_eye,left_eye_state,start_shake)
			right_eye_state = advance_eye_movement(right_eye,right_eye_state,start_shake)

func advance_eye_movement(eyes: Node2D, eyes_state: eye_state, start_shake: bool) -> eye_state:
	var small_eye: Node2D = eyes.get_child(0)
	var bulge_eye: Node2D = eyes.get_child(1)
	eyes.show()
	var eye_number := randi_range(0, 1)

	if ((eye_number == 0 and eyes_state == eye_state.NORMAL) or eyes_state == eye_state.BULGE):
		small_eye.show()
		bulge_eye.hide()
		eyes_state = eye_state.SMALL
	elif ((eye_number == 1 and eyes_state == eye_state.NORMAL) or eyes_state == eye_state.SMALL):
		small_eye.hide()
		bulge_eye.show()
		eyes_state = eye_state.BULGE

	if start_shake:
		start_eye_shaking(eyes)
	return eyes_state

func start_eye_shaking(eyes: Node2D):
	if eyes == left_eye:
		left_eye_shake = true
	elif eyes == right_eye:
		right_eye_shake = true

func has_clue_left() -> bool:
	if curr_round == 4:
		win_the_game.emit()
	return true

func _on_tears_timer_timeout() -> void:
	tears_mid.hide()
	tears_end.show()
	tears_timer.stop()

func _on_shake_timer_timeout() -> void:
	boss_shake_time = 0.0
	position = pos_boss
	shake_timer.stop()
