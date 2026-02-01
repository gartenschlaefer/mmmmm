# --
# hint

class_name Hint extends Node2D

# settings
@export var hint_type: Character_Enum.Hints

# refs
@onready var rufzeichen: Sprite2D = $rufzeichen
@onready var hint_sprite: Sprite2D = $hint_sprite
@onready var interaction_area: Area2D = $interaction_area

# vars
var is_hint_active = true
var is_hint_collected = false


func _ready():

	# var settings
	is_hint_active = false
	is_hint_collected = false

	# signal connection
	interaction_area.area_entered.connect(self.on_area_entered)
	interaction_area.area_exited.connect(self.on_area_exited)

	# hide sprite
	hint_sprite.hide()
	rufzeichen.hide()


func get_hint_type(): return hint_type


func on_area_entered(_area: Area2D):

	# rufzeichen
	rufzeichen.show()


func on_area_exited(_area: Area2D):

	# rufzeichen
	rufzeichen.hide()


func get_is_hint_active(): return is_hint_active
