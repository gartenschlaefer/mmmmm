# --
# hint

class_name Hint extends Node2D

# settings
@export var hint_type: Character_Enum.Hints

# refs
@onready var rufzeichen: Sprite2D = $rufzeichen

# vars
var is_hint_active = false
var is_hint_collected = false


func _ready():

	# var settings
	is_hint_active = false
	is_hint_collected = false


func get_hint_type(): return hint_type
